require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  def test_conversation_is_saved_when_sender_and_recipient_id_are_present
    conversation = build(:conversation)
    conversation.save

    assert conversation.persisted?
  end

  def test_conversation_does_not_save_when_sender_is_not_present
    conversation = build(:conversation)
    conversation.sender = nil
    conversation.save

    refute conversation.persisted?
  end

  def test_conversation_does_not_save_when_recipient_is_not_present
    conversation = build(:conversation)
    conversation.recipient = nil
    conversation.save

    refute conversation.persisted?
  end

  def test_conversation_does_not_save_when_sender_id_is_same_as_recipient_id
    conversation = build(:conversation)
    conversation.sender = conversation.recipient
    conversation.save

    refute conversation.persisted?
  end
end
