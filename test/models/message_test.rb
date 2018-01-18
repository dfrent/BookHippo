require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def test_message_saves_when_body_present
    message = build(:message)
    message.user = build(:user)
    message.save

    assert message.persisted?
  end

  def test_message_does_not_save_without_user
    message = build(:message)
    message.save

    refute message.persisted?
  end

  def test_message_does_not_save_without_conversation
    message = build(:message)
    message.conversation = nil
    message.save

    refute message.persisted?
  end

  def test_message_does_not_save_without_body
    message = build(:message)
    message.body = nil
    message.save

    refute message.persisted?
  end

  def test_message_is_not_read_when_saved
    message = build(:message)
    message.user = build(:user)
    message.save

    actual = message.read
    expected = false

    assert_equal(actual, expected)
  end

  def test_message_is_read_after_read_message_method_is_called
    message = build(:message)
    message.user = build(:user)
    message.save
    Message.read_message(message)

    actual = message.read
    expected = true

    assert_equal(actual, expected)
  end
end
