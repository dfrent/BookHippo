class BooksController < ApplicationController
  def index
    response = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=#{ENV['NYTIMES_KEY']}&list=mass-market-paperback")

    @books = []
    response.parsed_response["results"].each do |result|

      isbn = result["book_details"][0]["primary_isbn10"]
      book = Book.find_or_api_call(isbn)
      @books << book


      # goog_response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn=#{isbn}&key=#{ENV['GBOOKS_KEY']}")

      # book_img = goog_response.parsed_response["items"][0]["volumeInfo"]["imageLinks"]["smallThumbnail"]

      # @books << { title: result["book_details"][0]["title"], author: result["book_details"][0]["author"], description: result["book_details"][0]["description"], isbn: result["book_details"][0]["primary_isbn10"], book_image: book_img }

      # link_to("View Book", books_path(:id))

    end
  end

  def show
    isbn = params[:id]
    @book = Book.find_or_api_call(isbn)
  end

  def edit
  end

  def update
  end
end
