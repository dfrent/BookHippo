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
    @review.date_added = params[:review][:date_added]
    @review.book_id = params[:book_id]
    @review.user_id = current_user.id

    if @review.save
    respond_to do |format|
      format.html
      format.json {render json: @review}
    end
  end

    # if @review.save
    #   flash[:success] = "review added to #{@book.title}"
    #   redirect_to book_url(@book.isbn)
    # else
    #     flash.now[:alert] = "Sorry, there was a problem adding your review"
    #     render "/books/show"
    # end
  end

  def edit
    @review = Book.find(params[:book_id])
    @review = current_user.comments
  end

  def update
    @book = Book.find(params[:book_id])
    @review = Book.find(params[:book_id])
    @review.comment = params[:review][:comment]

    if @review.save
      flash[:success] = "your review was updated for #{@book.title}"
      redirect_to book_url(@book.isbn)
    else
        flash.now[:alert] = "Sorry, there was a problem updating your review"
        render "/books/show"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "You have successfully deleted your review"
    redirect_to books_url
  end

end
