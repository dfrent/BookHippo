require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def test_book_needs_a_title
    book = build(:book, title: nil)
    book.save
    refute book.persisted?
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
