class BooksController < ApplicationController
  GENRES = ['Mass Market Paperback', 'Travel', 'Science', 'Business Books', 'Animals', 'Education', 'Hardcover Nonfiction'].freeze
  def index
    @books = books_sorted_by_genre
  end

  def show
    isbn = params[:id]
    google = Tools::Google.new(isbn)
    @book = google.find_or_api_call
    @reading_list = ReadingList.new
    if logged_in?
      @existing_list = ReadingList.find_by(user_id: current_user.id, book_id: @book.id)
    end
    @review = Review.new
    @reviews = @book.reviews
    @average_rating = @book.average_rating

    # Checks if current_user is logged_in, then if they have a reading list with the current book. If they do, it sets that read_status in a variable
    if logged_in?
      if current_user.reading_lists.find_by(book_id: @book.id)
        @current_read_status = current_user.reading_lists.find_by(book_id: @book.id).read_status
      end
    end

    # Checks for presence of rating, and creates one for the user if it doesn't exist
    # Ensures user is logged in to prevent error do not move lines
    if logged_in?
      @rating = @book.ratings.find_by(user_id: current_user.id)

      unless @rating
        @rating = Rating.create(book_id: @book.id, user_id: current_user.id, stars: 0)
      end
    end
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
  end

  private

  def books_sorted_by_genre
    GENRES.each_with_object({}) do |genre, books|
      books[genre] = Book.where(ny_times_list: genre)
    end
  end
end
