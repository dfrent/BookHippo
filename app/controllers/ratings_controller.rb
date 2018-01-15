class RatingsController < ApplicationController
  def create

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
