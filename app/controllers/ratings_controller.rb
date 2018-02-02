class RatingsController < ApplicationController

skip_before_action :verify_authenticity_token

  def create

    @book = Book.find_by_isbn(params[:book_id])
      @rating = Rating.new

    if logged_in?
      @rating = Rating.find_by(user_id: current_user.id, book_id: @book.id)

      if @rating == nil
        @rating = Rating.create(book_id: @book.id, user_id: current_user.id, stars: params[:rating])

      else
        @rating.stars = params[:rating]
        @rating.save!
      end
    end

      Rails.logger.info(@rating.errors.inspect)
      if request.xhr?
      render json: @rating.stars
      end

  end

  def update
    @rating = Rating.find(params[:id])
    @rating.stars = params[:rating][:stars]

    if @rating.save
      render json: @rating.stars
    end
  end

  def destroy

  end

  def show

  end
end
