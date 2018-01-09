class BooksController < ApplicationController
  def index
    response = HTTParty.get("https://api.nytimes.com/svc/books/v3/lists.json?api-key=8177ba7834fc44ba85e618d089ca956e&list=mass-market-paperback")


    @books = []

    response.parsed_response["results"].each do |result|

      @isbn = result["book_details"][0]["primary_isbn10"]


      goog_response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn=#{@isbn}&key=AIzaSyDY0vkSLjkG15HziglfhAHBbYnHWntOkJ4")

      bookimg = goog_response.parsed_response["items"][0]["volumeInfo"]["imageLinks"]["smallThumbnail"]


      @books << { title: result["book_details"][0]["title"], author: result["book_details"][0]["author"], description: result["book_details"][0]["description"], isbn: result["book_details"][0]["primary_isbn10"], bookimage: bookimg }
    end


    # goog_response = HTTParty.get('https://www.googleapis.com/books/v1/volumes?q=isbn=1101622849&key=AIzaSyDY0vkSLjkG15HziglfhAHBbYnHWntOkJ4')

    # @bookimg = goog_response.parsed_response["items"][0]["volumeInfo"]["imageLinks"]["smallThumbnail"]

  end

  def show
  end

  def edit
  end

  def update
  end
end
