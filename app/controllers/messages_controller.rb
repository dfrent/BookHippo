class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
    @messages     = @conversation.messages
  end
  skip_before_action :verify_authenticity_token

  def index
    filled_message_page
    if params[:m]
      @over_ten = false
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
    @message = @conversation.messages.new
    @message.body = params[:body]
    @message.user_id = current_user.id
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def filled_message_page
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    @messages
  end
end
