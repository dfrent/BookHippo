class InterestsController < ApplicationController
  def creation
    @user = current_user
    params[:genres].each do |genre|
      interest = Interest.new
      interest.user_id = @user.id
      interest.genre_id = genre.to_i
      interest.save
    end
    redirect_to new_follow_url
  end
end
