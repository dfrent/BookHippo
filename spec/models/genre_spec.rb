require 'rails_helper'

RSpec.describe Genre, :type => :model do
  # ATTRIBUTES
  it 'is valid with valid attributes' do
    expect(build(:genre)).to be_valid
  end

  it 'is not valid without a name' do
    expect(build(:genre, name: nil)).not_to be_valid
  end

  it 'is not valid with a duplicate name' do
    genre = create(:genre)
    expect(build(:genre, name: genre.name)).not_to be_valid
  end
end
