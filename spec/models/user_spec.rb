require 'rails_helper'

RSpec.describe User, :type => :model do
  # ATTRIBUTES
  it 'is valid with valid attributes' do
    expect(build(:user)).to be_valid
  end

  it 'is not valid without a username' do
    expect(build(:user, username: nil)).not_to be_valid
  end

  it 'is not valid without an email' do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it 'is not valid without a password' do
    expect(build(:user, password: nil)).not_to be_valid
  end

  it 'is not valid without a password_confirmation' do
    expect(build(:user, password_confirmation: nil)).not_to be_valid
  end

  it 'is not valid if password is too short' do
    expect(build(:user, password: 'hi')).not_to be_valid
  end

  it 'is not valid if email is taken' do
    user = create(:user)
    duplicate_user = build(:user, email: user.email)
    expect(duplicate_user).not_to be_valid
  end

  # METHODS
  describe 'follow' do
    it 'can follow a user' do
      user = create(:user)
      other_user = create(:user)
      user.follow(other_user)

      expect(user.following).to include(other_user)
    end
  end

  describe 'unfollow' do
    it 'can unfollow a user'
  end

  describe 'following?' do
    it 'returns true if user is following passed user'
    it 'returns false if user is not following passed user'
  end

  describe 'one of their books' do
    it 'returns a book the user has in their list'
  end

  # CLASS METHODS
  describe 'users to follow' do
    it 'returns an array of users'
    it 'does not contain user'
    it 'returns no more than num_of_users users'
  end
end
