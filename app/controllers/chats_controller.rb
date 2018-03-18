class ChatsController < ApplicationController
  def create
    @chat = Chat.new(chat_params)
    @chat.user = current_user
    if @chat.save
      ActionCable.server.broadcast 'chats',
                                   chat: @chat.body,
                                   user: @chat.user.username
      head :ok
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:body, :book_club_id)
  end
end
