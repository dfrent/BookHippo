class ReadingListsController < ApplicationController
  before_action :ensure_logged_in

  def index
  end

  def show
  end

  def new
  end

  def create
    @book = Book.find(params[:book_id])
    @existing_list = ReadingList.find_by(user_id: params[:user_id], book_id: params[:book_id])

    if @existing_list.nil?
      @reading_list = ReadingList.create(user_id: params[:user_id],
                                         book_id: params[:book_id],
                                         read_status: params[:read_status])
    else
      @existing_list.read_status = params[:read_status]
      @existing_list.save
    end
    if request.xhr?

      @reviews = Review.where(book_id: params[:book_id])

      @rating = Rating.where(book_id: params[:book_id], user_id: current_user)
      puts "...........................................#{@rating.inspect}"

      if @rating == nil
        @rating = Rating.new
        @rating.stars = 0
      end
      render partial: "reviews/reviews_form", locals: {book: @book, review: Review.new, rating: @rating}
    else
      format.html { redirect_to book_path(@book[:isbn]) }
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
