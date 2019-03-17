class ConversationsController < ApplicationController
  before_action :ensure_logged_in

  def index
    @user = current_user
    @users = current_user.followers
    @conversations = Conversation.all
  end

  def create
    preexisting_conversation = Conversation.find_by(sender: params[:sender_id], recipient: params[:recipient_id])
    @conversation = if preexisting_conversation.present?
                      preexisting_conversation
                    else
                      Conversation.create!(conversation_params)
                    end
    redirect_to conversation_messages_path(@conversation, share: params[:share])
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
