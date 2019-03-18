require 'rails_helper'

RSpec.describe Message, :type => :model do
  # ATTRIBUTES
  it 'is valid with valid attributes' do
    expect(build(:message)).to be_valid
  end

  it 'is not valid without a body' do
    expect(build(:message, body: nil)).not_to be_valid
  end

  it 'is not valid without a conversation' do
    expect(build(:message, conversation: nil)).not_to be_valid
  end

  it 'is not valid without a user' do
    expect(build(:message, user: nil)).not_to be_valid
  end

  # RELATIONSHIPS
  it 'belongs to a conversation' do
    expect(create(:message).conversation).to be_present
  end

  it 'belongs to a user' do
    expect(create(:message).user).to be_present
  end

  # METHODS
  describe 'message_time' do
    it 'returns time correctly' do
      message = create(:message)
      message_time = message.created_at.strftime('%m/%d/%y at %l:%M %p')
      expect(message.message_time).to eq(message_time)
    end
  end

  # CLASS METHODS
  describe 'read_message' do
    it 'returns true if a book is found' do
      message = create(:message)
      expect(message.read).to equal(false)
      Message.read_message(message)
      expect(message.read).to equal(true)
    end
  end
end
