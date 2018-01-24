class BookClubsController < ApplicationController
  def index
  end

  def show
    @book_club = BookClub.find(params[:id])
    @message = Message.new
    Rails.logger.info(@message.errors.inspect)
    if request.xhr?
    render json: @message.body
    end
  end

  def new
  end

  def create
   message = Message.new(message_params)
   message.user = current_user
   if message.save

   else
     redirect_to book_club_path(@book_club)
   end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def message_params
    params.require(:message).permit(:body, :book_club_id)
  end
end
