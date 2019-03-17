class ReviewsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(
      comment: params[:review][:comment],
      date_added: params[:review][:date_added],
      book: @book,
      user: current_user
    )
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
    @review = Review.find(params[:book_id])
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
