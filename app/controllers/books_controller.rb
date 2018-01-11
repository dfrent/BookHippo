class BooksController < ApplicationController
  def index
    @books = Book.where("ny_times_list = ?", "Mass Market Paperback")
    @books_travel = Book.where("ny_times_list = ?", "Travel")
    @books_science = Book.where("ny_times_list = ?", "Science")
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
