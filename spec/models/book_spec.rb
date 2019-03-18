require 'rails_helper'

RSpec.describe Book, :type => :model do
  # ATTRIBUTES
  it 'is valid with valid attributes' do
    expect(build(:book)).to be_valid
  end

  it 'is not valid without an isbn'
  it 'is not valid without an author'
  it 'is not valid without a title'
  it 'is not valid without a book cover'
  it 'is not valid without a description'
  it 'is not valid if isbn is taken'

  # RELATIONSHIPS
  it 'is not valid without a genre'
  it 'can have many users through reviews'
  it 'can have many users through ratings'
  it 'can have many reviews'
  it 'can have many reading lists'
  it 'can have many ratings'
end
