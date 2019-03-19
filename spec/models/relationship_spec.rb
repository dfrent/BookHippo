require 'rails_helper'

RSpec.describe Relationship, :type => :model do
  # ATTRIBUTES
  it 'is valid with valid attributes' do
    expect(build(:relationship)).to be_valid
  end

  it 'is not valid without a follower' do
    expect(build(:relationship, follower: nil)).not_to be_valid
  end

  it 'is not valid without an followed' do
    expect(build(:relationship, followed: nil)).not_to be_valid
  end

  it 'is not valid if follower is followed' do
    user = create(:user)
    relationship = build(:relationship)
    relationship.followed = user
    relationship.follower = user
    expect(relationship).not_to be_valid
  end

  # RELATIONSHIPS
  it 'belongs to a follower' do
    expect(create(:relationship).follower).to be_present
  end

  it 'belongs to a followed' do
    expect(create(:relationship).followed).to be_present
  end
end
