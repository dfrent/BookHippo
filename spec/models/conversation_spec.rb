require 'rails_helper'

RSpec.describe Conversation, :type => :model do
  # ATTRIBUTES
  it 'is not valid without a sender' do
    expect(build(:conversation, sender: nil)).not_to be_valid
  end

  it 'is not valid without a recipient' do
    expect(build(:conversation, recipient: nil)).not_to be_valid
  end

  it 'is not valid if sender is recipient' do
    user = create(:user)
    conversation = build(:conversation)
    conversation.sender = user
    conversation.recipient = user
    expect(conversation).not_to be_valid
  end

  # RELATIONSHIPS
  it 'belongs to a sender' do
    expect(create(:conversation).sender).to be_present
  end

  it 'belongs to a recipient' do
    expect(create(:conversation).recipient).to be_present
  end
end
