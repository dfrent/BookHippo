require 'rails_helper'

RSpec.describe RejectedIsbn, :type => :model do
  # ATTRIBUTES
  it 'is valid with valid attributes' do
    expect(build(:rejected_isbn)).to be_valid
  end

  it 'is not valid without an isbn' do
    expect(build(:rejected_isbn, isbn: nil)).not_to be_valid
  end

  # CLASS METHODS
  describe 'record_invalid_isbn' do
    it 'creates a new rejected isbn' do
      isbn = '1234567890'
      RejectedIsbn.record_invalid_isbn(isbn)
      expect(RejectedIsbn.last.isbn).to equal(isbn)
    end
  end

  describe 'isbn_is_rejected' do
    it 'returns true if there is a rejected isbn matching the isbn' do
      isbn = '1234567890'
      create(:rejected_isbn, isbn: isbn)
      expect(RejectedIsbn.isbn_is_rejected(isbn)).to equal(true)
    end

    it 'returns false if there is not a rejected isbn matching the isbn' do
      isbn = '1234567890'
      expect(RejectedIsbn.isbn_is_rejected(isbn)).to equal(false)
    end
  end
end
