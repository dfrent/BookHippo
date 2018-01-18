require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def test_message_saves_when_body_present
    conversation = build(:conversation)
    conversation.save
    message = build(:message)
    message.conversation = conversation
    message.user = conversation.sender
    message.save
    
    assert message.persisted?
  end
end
