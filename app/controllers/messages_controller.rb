class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  skip_before_action :verify_authenticity_token

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.each do |message|
          message.update_column(:read, true)
        end
      end
    end
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = Message.new
    if @message.conversation_id != nil
      @message = @conversation.messages.new
      @message.body = params[:body]
      @message.user_id = current_user.id
      if @message.save
        redirect_to conversation_messages_path(@conversation)
      end
    elsif @message.book_id != nil
      @message = Message.new(message_params)
      @message.user = current_user
      if @message.save
        ActionCable.server.broadcast 'messages',
          message: @message.body,
          user: @message.user.username
        head :ok
      end
    end
  end
end
