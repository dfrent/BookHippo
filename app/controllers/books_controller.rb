class BooksController < ApplicationController
  def index
    @books = Book.where("ny_times_list = ?", "mass-market-paperback")
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
