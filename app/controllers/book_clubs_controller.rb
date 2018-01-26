class BookClubsController < ApplicationController
  def index
    @book_clubs = BookClub.all
  end

  def show
    @book_club = BookClub.find(params[:id])
    @chat = Chat.new
    Rails.logger.info(@chat.errors.inspect)
    if request.xhr?
      render json: @chat.body
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

  def chat_params
    params.require(:chat).permit(:body, :book_club_id)
  end
end
