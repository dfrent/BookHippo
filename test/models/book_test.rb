require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

# Validation Testing
  def test_book_needs_a_title
    book = build(:book, title: nil)
    book.save
    refute book.persisted?
  end

  def test_book_needs_a_isbn
    book = build(:book, isbn: nil)
    book.save
    refute book.persisted?
  end

  def test_book_needs_a_book_cover
    book = build(:book, book_cover: nil)
    book.save
    refute book.persisted?
  end

  def test_book_needs_a_description
    book = build(:book, description: nil)
    book.save
    refute book.persisted?
  end

# Testing isbn uniqueness
  def test_book_needs_a_isbn_is_unique
    book = create(:book, isbn: '123456789')
    # book2 = build(:book)
    book2 = Book.new(isbn: "123456789", title: "jayz", author: 'Thomas the Tank',
        average_rating: '3',
        book_cover: 'poster',
        description: 'history')
    refute book2.valid?
  end

  def test_create_a_book
    book = create(:book)
    assert book.persisted?
  end

  def test_book_has_a_title
    book = Book.create(title: "Cat in the Hat")
    assert_equal("Cat in the Hat", book.title)
  end

  def test_book_can_update_title
    book = Book.create(title: "Cat in the Hat")
    book.title = "Sherlock Holmes"
    book.save
    assert_equal("Sherlock Holmes", book.title)
  end

  def test_book_can_be_destroyed
    book = Book.create(title: "The Shining")
    book.destroy
    refute book.persisted?
  end


end
