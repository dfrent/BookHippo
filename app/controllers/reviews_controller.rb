class ReviewsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @review = Review.new
    @book = Book.find(params[:book_id])
    @review.comment = params[:review][:comment]
    @review.date_added = params[:review][:date_added]
    @review.book = @book
    @review.user_id = current_user.id

    if @review.save
      respond_to do |format|
        format.html { redirect_to book_path(@book[:isbn]) }
        format.json { render json: @review }
      end
    else
      render json: { :errors => @review.errors }
    end
  end

  def update
    @book = Book.find(params[:book_id])
    @review = Book.find(params[:book_id])
    @review.comment = params[:review][:comment]

    if @review.save
      flash[:success] = "your review was updated for #{@book.title}"
      redirect_to book_url(@book.isbn)
    else
      flash.now[:alert] = 'Sorry, there was a problem updating your review'
      render '/books/show'
    end
  end
end
