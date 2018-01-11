class ReviewsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @review = Review.new
    @book = Book.find(params[:book_id])
  end

  def create
    @review = Review.new
    @book = Book.find(params[:book_id])
    @review.comment = params[:review][:comment]
    @review.stars = params[:review][:stars]
    @review.book_id = params[:book_id]
    @review.user_id = current_user.

    if @review.save
      flash[:success] = "review added to #{@review.book.title}"
      redirect_to @book
    else
        flash.now[:alert] = "Sorry, there was a problem adding your review"
        render 'books'
    end
  end

  def edit
    @review = Book.find(params[:book_id])
    @review = current_user.comments
  end

  def update
    @book = Book.find(params[:book_id])
    @review = Book.find(params[:book_id])
    @review.comment = params[:review][:comment]


  end

  def destroy
  end

end
