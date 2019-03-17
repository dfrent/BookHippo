class RatingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @book = Book.find_by_isbn(params[:book_id])
    @rating = Rating.new
    find_or_create_rating if logged_in?

    render json: @rating.stars if request.xhr?
  end

  def update
    @rating = Rating.find(params[:id])
    @rating.stars = params[:rating][:stars]

    render json: @rating.stars if @rating.save
  end

  private

  def find_or_create_rating
    @rating = Rating.find_by(user_id: current_user.id, book_id: @book.id)

    if @rating
      @rating.update_attribute(:stars, params[:rating])
    else
      @rating = Rating.create(book_id: @book.id, user_id: current_user.id, stars: params[:rating])
    end
  end
end
