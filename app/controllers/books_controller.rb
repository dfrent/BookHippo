class BooksController < ApplicationController
  def index
    @books_top = Book.where("ny_times_list = ?", "Mass Market Paperback")
    @books_travel = Book.where("ny_times_list = ?", "Travel")
    @books_science = Book.where("ny_times_list = ?", "Science")
    @books_business = Book.where("ny_times_list = ?", "Business Books")
    @books_animals = Book.where("ny_times_list = ?", "Animals")
    @books = {"Top Selling" => @books_top, "Travel" =>  @books_travel, "Science" => @books_science, "Business" => @books_business, "Animals" => @books_animals}
  end

  def show
    isbn = params[:id]
    @test_rating = 4
    @book = Book.find_or_api_call(isbn)
    @reading_list = ReadingList.new
    if logged_in?
      @existing_list = ReadingList.find_by(user_id: current_user.id, book_id: @book.id)
    end
    @review = Review.new
    @reviews = @book.reviews

    # Checks if current_user is logged_in, then if they have a reading list with the current book. If they do, it sets that read_status in a variable
    if logged_in?
      if current_user.reading_lists.find_by(book_id: @book.id)
        @current_read_status = current_user.reading_lists.find_by(book_id: @book.id).read_status
      end
    end

    # Checks for presence of rating, and creates one for the user if it doesn't exist
    #Ensures user is logged in to prevent error do not move lines
    if logged_in?
      @rating = @book.ratings.find_by(user_id: current_user.id)

      unless @rating
        @rating = Rating.create(book_id: @book.id, user_id: current_user.id, stars: 0)
      end
    end
    ###

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
