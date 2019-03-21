module Tools
  class Google
    attr_accessor :isbn, :book, :volume_info, :images

    GOOGLE_ENDPOINT = 'https://www.googleapis.com/books/v1/volumes?q='.freeze
    GBOOKS_KEY = ENV['GBOOKS_KEY']

    def initialize(isbn = nil)
      @isbn = isbn
    end

    def update_books_by_genre
      books_for_all_genres.each do |books_list|
        books_list.each do |genre_id, books|
          books.each do |book|
            next unless book && book['volumeInfo']
            isbns = book['volumeInfo']['industryIdentifiers']
            next unless isbns
            isbn = isbn_10_from_isbns(isbns)
            next if isbn.nil? || Book.exists?(isbn)
            create_book(genre_id, isbn)
          end
        end
      end
    end

    def books_for_all_genres
      Genre.all.map do |genre|
        books_in_genre(genre.name, genre.id)
      end
    end

    def books_in_genre(genre_name, genre_id)
      response = HTTParty.get("#{GOOGLE_ENDPOINT}subject=#{genre_name}&key=#{GBOOKS_KEY}")
      {
        "#{genre_id}": response.parsed_response['items']
      }
    end

    def assign_images_to_all_books
      Book.all.map do |book|
        next if book.book_cover || book.small_thumbnail
        prep_book_for_update(book, book.isbn)
        book.save if book.valid?
      end
    end

    def isbn_10_from_isbns(identifiers)
      isbn = nil
      identifiers&.each do |identifier|
        isbn = identifier['identifier'] if identifier['type'] == 'ISBN_10'
      end
      isbn
    end

    def find_or_api_call
      book = Book.find_by(isbn: @isbn)
      return book if book
      create_book(@isbn)
    end

    def book_search(query)
      response = HTTParty.get("#{GOOGLE_ENDPOINT}#{query}&key=#{GBOOKS_KEY}")
      response.parsed_response['items']
    end

    # Lookup

    def book_from_isbn(isbn)
      response = HTTParty.get("#{GOOGLE_ENDPOINT}isbn=#{isbn}&key=#{GBOOKS_KEY}")
      response.parsed_response['items'][0]
    end

    # Model Creation/ Updates

    def create_book(genre_id = 20, isbn = nil)
      book = Book.new
      volume_info = prep_book_for_update(book)
      return unless volume_info
      book.assign_attributes(book_attributes(volume_info, genre_id, book))
      if book.valid?
        book.save
        return book
      end
      RejectedIsbn.record_invalid_isbn(isbn)
      nil
    end

    def book_attributes(volume_info, genre_id, book)
      {
        title: volume_info['title'],
        author: account_for_multiple_authors(volume_info),
        description: volume_info['description'] || '',
        genre_id: genre_id,
        isbn: isbn,
        google_id: book['id'],
        page_count: volume_info['pageCount'],
        average_rating: volume_info['averageRating'],
        published_date: volume_info['publishedDate'],
        publisher: volume_info['publisher']
      }
    end

    def account_for_multiple_authors(volume_info)
      return unless volume_info['authors']
      authors = volume_info['authors']
      return '' unless authors
      authors.length > 1 ? authors : authors.join(', ')
    end

    def prep_book_for_update(book, isbn = nil)
      return false if RejectedIsbn.isbn_is_rejected(isbn)
      book_data = book_from_isbn(isbn)
      images = book_data['volumeInfo']['imageLinks']
      assign_images(images, book)
      book_data['volumeInfo']
    end

    def assign_images(image_links, book)
      return false if image_links.nil?
      book[:book_cover] = image_links['thumbnail']
      book[:small_thumbnail] = image_links['smallThumbnail']
    end
  end
end
