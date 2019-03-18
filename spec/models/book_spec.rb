require 'rails_helper'

RSpec.describe Book, :type => :model do
  # ATTRIBUTES
  it 'is valid with valid attributes' do
    expect(build(:book)).to be_valid
  end

  it 'is not valid without an isbn' do
    expect(build(:book, isbn: nil)).not_to be_valid
  end

  it 'is not valid without an author' do
    expect(build(:book, author: nil)).not_to be_valid
  end

  it 'is not valid without a title' do
    expect(build(:book, title: nil)).not_to be_valid
  end

  it 'is not valid without a book cover' do
    expect(build(:book, book_cover: nil)).not_to be_valid
  end

  it 'is not valid without a description' do
    expect(build(:book, description: nil)).not_to be_valid
  end

  it 'is not valid if isbn is taken' do
    book = create(:book)
    duplicate_book = build(:book, isbn: book.isbn)
    expect(duplicate_book).not_to be_valid
  end

  it 'is not valid without a genre' do
    expect(build(:book, genre: nil)).not_to be_valid
  end

  # RELATIONSHIPS
  it 'belongs to a genre' do
    expect(create(:book).genre).to be_present
  end

  # METHODS
  it 'returns an average rating' do
    book = create(:book)
    3.times do
      create(:rating, book: book)
    end

    average_rating = book.ratings.inject(0) do |total, rating|
      rating.stars.round + total
    end / 3

    expect(book.average_rating).to equal(average_rating)
  end

  it 'returns false for average rating if there are none' do
    book = create(:book)

    expect(book.average_rating).to equal(false)
  end

  # CLASS METHODS
  describe 'exists?' do
    it 'returns true if a book is found' do
      book = create(:book)
      expect(Book.exists?(book.isbn)).to equal(true)
    end

    it 'returns false if no book is found' do
      expect(Book.exists?('1234567890')).to equal(false)
    end
  end
end
