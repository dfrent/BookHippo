module Tools
  class Google
    attr_accessor :isbn, :book

    def initialize(isbn)
      @isbn = isbn
      @book = Book.new
    end

    def find_or_api_call
      book = Book.find_by(isbn: @isbn)
      return book if book
      @book.update_attributes(new_book_data)
      return @book.errors.messages unless @book.valid?
      book.save
      book
    end

    private

    def book_from_isbn
      response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn=#{@isbn}&key=#{ENV['GBOOKS_KEY']}")
      response.parsed_response['items'][0]
    end

    def new_book_data
      book = book_from_isbn
      book_volume_info = book['volumeInfo']
      assign_book_images(book_volume_info['imageLinks'])
      authors = book_volume_info['authors']
      authors = authors.length > 1 ? authors : authors.join(', ')
      @book.update_attributes(title: book_volume_info['title'],
                              author: authors,
                              description: book_volume_info['description'],
                              genre_id: 20,
                              isbn: @isbn,
                              google_id: book['id'],
                              page_count: book_volume_info['pageCount'],
                              average_rating: book_volume_info['averageRating'],
                              published_date: book_volume_info['publishedDate'],
                              publisher: book_volume_info['publisher'])
    end

    def assign_book_images(image_links)
      return if image_links.nil?
      @book[:book_cover] = image_links['thumbnail']
      @book[:small_thumbnail] = image_links['smallThumbnail']
    end
  end
end
