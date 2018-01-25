class ChatsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chats'
  end
end
