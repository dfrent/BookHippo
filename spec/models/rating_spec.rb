require 'rails_helper'

RSpec.describe Rating, :type => :model do
  # ATTRIBUTES
  it 'is valid with valid attributes' do
    expect(build(:rating)).to be_valid
  end

  it 'is not valid without a user' do
    expect(build(:rating, user: nil)).not_to be_valid
  end

  it 'is not valid without a book' do
    expect(build(:rating, book: nil)).not_to be_valid
  end

  it 'is not valid if stars are negative' do
    expect(build(:rating, stars: -1)).not_to be_valid
  end

  it 'is not valid if stars are above 5' do
    expect(build(:rating, stars: 6)).not_to be_valid
  end

  it 'is not valid if stars are nil' do
    expect(build(:rating, stars: nil)).not_to be_valid
  end

  # RELATIONSHIPS
  it 'belongs to a user' do
    expect(create(:rating).user).to be_present
  end

  it 'belongs to a book' do
    expect(create(:rating).book).to be_present
  end
end
