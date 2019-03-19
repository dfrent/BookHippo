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

    it 'cannot follow yourself' do
      user = create(:user)

      expect { user.follow(user) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'unfollow' do
    it 'can unfollow a user' do
      user = create(:user)
      other_user = create(:user)
      user.follow(other_user)
      expect(user.following).to include(other_user)

      user.unfollow(other_user)
      expect(user.following).not_to include(other_user)
    end
  end

  describe 'following?' do
    it 'returns true if user is following passed user' do
      user = create(:user)
      other_user = create(:user)
      user.follow(other_user)

      expect(user.following?(other_user)).to equal(true)
    end

    it 'returns false if user is not following passed user' do
      user = create(:user)
      other_user = create(:user)

      expect(user.following?(other_user)).to equal(false)
    end
  end

  describe 'one of their books' do
    it 'returns a book the user has in their list' do
      reading_list = create(:reading_list)
      user = reading_list.user
      book = reading_list.book

      expect(user.one_of_their_books).to eq(book)
    end
  end

  # CLASS METHODS
  describe 'users to follow' do
    it 'returns an array of users' do
      user = create(:user)
      other_user = create(:user)

      expect(User.users_to_follow(10, user)).to include(other_user)
    end

    it 'does not contain passed user' do
      user = create(:user)

      expect(User.users_to_follow(10, user)).not_to include(user)
    end

    it 'returns no more than num_of_users users' do
      12.times do
        create(:user)
      end

      expect(User.users_to_follow(10, User.first).length).to equal(10)
    end
  end
end
