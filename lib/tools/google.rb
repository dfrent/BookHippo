module Tools
  class Google
    attr_accessor :isbn

    def initialize(isbn)
      @isbn = isbn
    end

    def find_or_api_call
      book = Book.find_by(isbn: @isbn)
      return book if book
      book = Book.new(new_book_data)
      return unless book.valid?
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
      authors = book['authors'].length > 1 ? book['authors'] : book['authors'].join(', ')
      { title: book_volume_info['title'],
        author: authors,
        description: book_volume_info['description'],
        genre_id: 20,
        google_id: book['id'],
        page_count: book_volume_info['pageCount'],
        average_rating: book_volume_info['averageRating'],
        published_date: book_volume_info['publishedDate'],
        publisher: book_volume_info['publisher'] }
    end
  end
end
