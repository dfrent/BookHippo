module Tools
  class Google
    attr_accessor :isbn, :book, :volume_info, :images

    GOOGLE_ENDPOINT = 'https://www.googleapis.com/books/v1/volumes?q='.freeze
    GBOOKS_KEY = ENV['GBOOKS_KEY']

    def initialize(isbn = nil)
      @isbn = isbn
    end

    # Public Methods

    def update_books_by_genre
      books_for_all_genres.each do |genre_id, books_list|
        books_list.each do |book|
          next unless book && book['volumeInfo']
          isbns = book['volumeInfo']['industryIdentifiers']
          next unless isbns
          isbn = isbn_10_from_isbns(isbns)
          next if isbn.nil? || Book.exists?(isbn)
          create_book(genre_id)
        end
      end
    end

    def find_or_api_call
      book = Book.find_by(isbn: @isbn)
      return book if book
      create_book
    end

    def assign_images_to_all_books
      Book.all.map do |book|
        next if book.book_cover || book.small_thumbnail
        @isbn = book.isbn
        prep_book_for_update(book)
        book.save if book.valid?
      end
    end

    def book_search(query)
      response = HTTParty.get("#{GOOGLE_ENDPOINT}#{query}&key=#{GBOOKS_KEY}")
      response.parsed_response['items']
    end

    def isbn_10_from_isbns(identifiers)
      identifiers&.each do |identifier|
        @isbn = identifier['identifier'] if identifier['type'] == 'ISBN_10'
      end
      @isbn
    end

    private

    # General Methods
    def book_from_isbn(isbn)
      response = HTTParty.get("#{GOOGLE_ENDPOINT}isbn=#{isbn}&key=#{GBOOKS_KEY}")
      response.parsed_response['items'][0]
    end

    def create_book(genre_id = 20)
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

    def prep_book_for_update(book)
      return nil if RejectedIsbn.isbn_is_rejected(@isbn) || @isbn.nil?
      book_data = book_from_isbn(@isbn)
      images = book_data['volumeInfo']['imageLinks']
      assign_images(images, book)
      book_data['volumeInfo']
    end

    def assign_images(image_links, book)
      return false if image_links.nil?
      book[:book_cover] = image_links['thumbnail']
      book[:small_thumbnail] = image_links['smallThumbnail']
    end

    # Genre-based Methods
    def books_for_all_genres
      Genre.all.each_with_object({}) do |genre, genres|
        genres[genre.id] = books_in_genre(genre.name)
        genres
      end
    end

    def books_in_genre(genre_name)
      response = HTTParty.get("#{GOOGLE_ENDPOINT}subject=#{genre_name}&key=#{GBOOKS_KEY}")
      response.parsed_response['items']
    end
  end
end
