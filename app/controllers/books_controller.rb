class BooksController < ApplicationController
  GENRES = ['Mass Market Paperback', 'Travel', 'Science', 'Business Books', 'Animals', 'Education', 'Hardcover Nonfiction'].freeze

  def index
    @books = books_sorted_by_genre
    json_response(@books)
  end

  def show
    isbn = params[:id]
    google = Tools::Google.new(isbn)
    @book = google.find_or_api_call
    @reading_list = ReadingList.new
    @review = Review.new
    @reviews = @book.reviews
    @average_rating = @book.average_rating
    set_logged_in_show_variables
  end

  def recommendations
    @user = current_user
    redirect_to root_url unless logged_in?

    @genres = @user.genres.ids
    @books = []
    @reading_list = ReadingList.new
  end

  private

  def books_sorted_by_genre
    GENRES.each_with_object({}) do |genre, books|
      books[genre] = Book.where(ny_times_list: genre)
    end
  end

  def set_logged_in_show_variables
    return unless logged_in?
    @existing_list = ReadingList.find_by(user_id: current_user.id, book_id: @book.id)
    reading_list_status = current_user.reading_lists.find_by(book_id: @book.id)
    @current_read_status = reading_list_status.read_status if reading_list_status
    book_rating = @book.ratings.find_by(user_id: current_user.id)
    @rating = book_rating || Rating.create(book_id: @book.id, user_id: current_user.id, stars: 0)
  end

  def json_response(variables)
    respond_to do |f|
      f.html
      f.json { render json: variables }
    end
  end
end
