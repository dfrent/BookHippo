module Tools
  class Google
    attr_accessor :isbn, :book, :volume_info, :images

    GOOGLE_ENDPOINT = 'https://www.googleapis.com/books/v1/volumes?q='.freeze

    def initialize(isbn = nil)
      @isbn = isbn
      @book = Book.new
    end

    def find_or_api_call
      book = Book.find_by(isbn: @isbn)
      return book if book
      create_book
    end

    def update_books_by_genre
      Genre.all.each do |genre|
        books_in_genre(genre.name).each do |item|
          isbn_10_from_api(item['volumeInfo']['industryIdentifiers'])
          next if @isbn.nil? || Book.exists?(@isbn)
          create_book(genre.id)
        end
      end
    end

    private

    # Lookup

    def book_from_isbn
      response = HTTParty.get("#{GOOGLE_ENDPOINT}isbn=#{@isbn}&key=#{ENV['GBOOKS_KEY']}")
      response.parsed_response['items'][0]
    end

    def books_in_genre(genre_name)
      response = HTTParty.get("#{GOOGLE_ENDPOINT}subject=#{genre_name}&key=#{ENV['GBOOKS_KEY']}")
      response.parsed_response['items']
    end

    def fetch_book_data
      book_data = book_from_isbn
      @volume_info = book_data['volumeInfo']
      @images = @volume_info['imageLinks']
    end

    # Model Creation

    def create_book(genre_id = 20)
      fetch_book_data
      assign_book_images
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
      @book = Book.new
    end

    def assign_book_images
      return if @images.nil?
      @book[:book_cover] = @images['thumbnail']
      @book[:small_thumbnail] = @images['smallThumbnail']
    end

    def isbn_10_from_api(identifiers)
      identifiers&.each do |identifier|
        @isbn = identifier['identifier'] if identifier['type'] == 'ISBN_10'
      end
    end

    def account_for_multiple_authors
      authors = @volume_info['authors']
      return '' unless authors
      authors.length > 1 ? authors : authors.join(', ')
    end
  end
end
