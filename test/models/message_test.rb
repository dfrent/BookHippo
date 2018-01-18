require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

# Validation Testing
  def test_message_has_a_body
    message = build(:message, body: nil)
    message.save
    refute message.persisted?
  end


  def test_read_message
    message = build(:message)
    assert_not_equal(true, message.read)
    
    Message.read_message(message)

    actual = message.read
    expected = true

    assert_equal(expected, actual)
  end

end
