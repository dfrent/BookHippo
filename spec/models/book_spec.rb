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
end
