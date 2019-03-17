class InterestsController < ApplicationController
  def creation
    user = current_user
    params[:genres].each do |genre|
      Interest.create(
        user: user,
        genre_id: genre.to_i
      )
    end
    redirect_to recommendations_url
  end
end
