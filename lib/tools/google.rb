module Tools
  class Google
    attr_accessor :isbn, :book, :volume_info, :images

    GOOGLE_ENDPOINT = 'https://www.googleapis.com/books/v1/volumes?q='.freeze
    GBOOKS_KEY = ENV['GBOOKS_KEY']

    def initialize(isbn = nil)
      @isbn = isbn
    end

    def find_or_api_call
      book = Book.find_by(isbn: @isbn)
      return book if book
      create_book
    end

    def update_books_by_genre
      books_for_all_genres.each do |item|
        isbn_10_from_api(item['volumeInfo']['industryIdentifiers'])
        next if @isbn.nil? || Book.exists?(@isbn)
        create_book(genre.id)
      end
    end

    def assign_images_to_all_books
      Book.all.map do |book|
        next if book.book_cover || book.small_thumbnail
        @isbn = book.isbn
        @book = book
        prep_book_for_update
        @book.save if @book.valid?
      end
    end

    def book_search(query)
      response = HTTParty.get("#{GOOGLE_ENDPOINT}#{query}&key=#{GBOOKS_KEY}")
      response.parsed_response['items']
    end

    def isbn_10_from_api(identifiers)
      identifiers&.each do |identifier|
        @isbn = identifier['identifier'] if identifier['type'] == 'ISBN_10'
      end
      @isbn
    end

    private

    # Lookup

    def book_from_isbn
      return unless @isbn
      response = HTTParty.get("#{GOOGLE_ENDPOINT}isbn=#{@isbn}&key=#{GBOOKS_KEY}")
      response.parsed_response['items'][0]
    end

    def books_in_genre(genre_name)
      response = HTTParty.get("#{GOOGLE_ENDPOINT}subject=#{genre_name}&key=#{GBOOKS_KEY}")
      response.parsed_response['items']
    end

    def books_for_all_genres
      Genre.all.map do |genre|
        books_in_genre(genre.name)
      end
    end

    # Model Creation/ Updates

    def create_book(genre_id = 20)
      @book = Book.new
      return unless prep_book_for_update
      @book.update_attributes(title: @volume_info['title'],
                              author: account_for_multiple_authors,
                              description: @volume_info['description'] || '',
                              genre_id: genre_id,
                              isbn: @isbn,
                              google_id: book['id'],
                              page_count: @volume_info['pageCount'],
                              average_rating: @volume_info['averageRating'],
                              published_date: @volume_info['publishedDate'],
                              publisher: @volume_info['publisher'])
      if book.valid?
        @book
      else
        RejectedIsbn.record_invalid_isbn(@isbn)
        return
      end
    end

    def account_for_multiple_authors
      return unless @volume_info['authors']
      authors = @volume_info['authors']
      return '' unless authors
      authors.length > 1 ? authors : authors.join(', ')
    end

    def prep_book_for_update
      return false unless @isbn
      return false if RejectedIsbn.isbn_is_rejected(@isbn)
      book_data = book_from_isbn
      @volume_info = book_data['volumeInfo']
      @images = @volume_info['imageLinks']
      return if @images.nil?
      @book[:book_cover] = @images['thumbnail']
      @book[:small_thumbnail] = @images['smallThumbnail']
    end
  end
end
