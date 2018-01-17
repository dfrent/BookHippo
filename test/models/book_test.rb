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

# # Testing isbn uniqueness
#   def test_book_needs_a_isbn_is_unique
#     book1 = build(:book, isbn: "1")
#     book2 = build(:book, isbn: "1")
#     book1.save
#     book2.save
#     refute book1.persisted?
#     refute book2.persisted?
#   end




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
