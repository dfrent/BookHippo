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
    book2 = Book.new(isbn: "123456789",
                     title: "jayz",
                     author: 'Thomas the Tank',
                     average_rating: '3',
                     book_cover:     'poster',
                     description:    'history')
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

  def test_find_or_api_call_returns_book_with_correct_isbn
    book = Book.find_or_api_call("0826215491")
    expected = "0826215491"
    actual = book.isbn

    assert_equal(actual, expected)
  end

  def test_find_or_api_call_returns_book_if_it_already_exists
    book = build(:book)
    actual = Book.find_or_api_call(book.isbn).isbn
    expected = '123456789'

    assert_equal(actual, expected)
  end

  def test_book_exists_returns_false_if_book_does_not_exist
    book_presence = Book.exists?("123456789")

    refute book_presence
  end

  def test_book_exists_returns_true_if_book_exists
    book = build(:book)
    book_presence = Book.exists?(book.isbn)

    refute book_presence
  end
end
