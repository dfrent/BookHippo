class BooksController < ApplicationController
  def index
    @books = Book.where("ny_times_list = ?", "Mass Market Paperback")
    @books_travel = Book.where("ny_times_list = ?", "Travel")
    @books_science = Book.where("ny_times_list = ?", "Science")
    @books_business = Book.where("ny_times_list = ?", "Business Books")
    @books_animals = Book.where("ny_times_list = ?", "Animals")
  end

  def show
    isbn = params[:id]
    @book = Book.find_or_api_call(isbn)
    @reading_list = ReadingList.new
    if logged_in?
      @existing_list = ReadingList.find_by(user_id: current_user.id, book_id: @book.id)
    end
    @review = Review.new
    @reviews = @book.reviews
  end

  def edit
  end

  def update
  end

  def recommendations
    @user = current_user
    if logged_in?
      @genres = @user.genres.ids
    else
      redirect_to root_url
    end
    @books = []
    @reading_list = ReadingList.new
    # @books = Book.where('genre_id = ?', "16")
  end
end
