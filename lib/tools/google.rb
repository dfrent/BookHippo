module Tools
  class Google
    def self.book_from_isbn(isbn)
      response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn=#{isbn}&key=#{ENV['GBOOKS_KEY']}")
      response.parsed_response['items']
    end
  end
end
