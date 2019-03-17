class MessagesController < ApplicationController
  MAX_MESSAGES_PER_PAGE = 10

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages
  end
  skip_before_action :verify_authenticity_token

  def index
    filled_message_page
    @over_ten = false if params[:m]
    @message = @conversation.messages.new

    return unless @messages
    if @messages.last.user_id != current_user.id
      @messages.map do |message|
        message.update_column(:read, true)
      end
    end
  end

  def create
    @message = @conversation.messages.new(
      body: params[:body],
      user: current_user
    )
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def filled_message_page
    return @messages if @messages.length <= MAX_MESSAGES_PER_PAGE
    @over_ten = true
    @messages = @messages[-MAX_MESSAGES_PER_PAGE..-1]
  end
end
