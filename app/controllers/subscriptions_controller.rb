class SubscriptionsController < ApplicationController
  def creation
    @book_club = BookClub.find(params[:book_club_id])
    params[:invitees].each do |invitee|
      subscription = Subscription.new
      subscription.book_club_id = @book_club.id
      subscription.user_id = invitee.to_i
      subscription.save
    end
    redirect_to book_club_url(@book_club)
  end
end
