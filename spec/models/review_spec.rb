require 'rails_helper'

RSpec.describe Review, :type => :model do
  # ATTRIBUTES
  it 'is valid with valid attributes' do
    expect(build(:review)).to be_valid
  end

  it 'is not valid without a user' do
    expect(build(:review, user: nil)).not_to be_valid
  end

  it 'is not valid without a book' do
    expect(build(:review, book: nil)).not_to be_valid
  end

  it 'is not valid without a comment' do
    expect(build(:review, comment: nil)).not_to be_valid
  end

  # RELATIONSHIPS
  it 'belongs to a user' do
    expect(create(:review).user).to be_present
  end

  it 'belongs to a book' do
    expect(create(:review).book).to be_present
  end

  # METHODS
  describe 'review_time' do
    it 'returns correct value' do
      review = create(:review)
      review_time = review.created_at.strftime('%m/%d/%y at %l:%M %p')
      expect(review.review_time).to eq(review_time)
    end
  end

  describe 'username_display' do
    it 'returns correct value' do
      review = create(:review)
      username = review.user.username.capitalize
      expect(review.username_display).to eq(username)
    end
  end
end
