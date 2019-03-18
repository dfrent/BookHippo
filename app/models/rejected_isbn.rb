class RejectedIsbn < ApplicationRecord
  validates :isbn, presence: true

  def self.record_invalid_isbn(isbn)
    RejectedIsbn.create(isbn: isbn)
  end

  def self.isbn_is_rejected(isbn)
    RejectedIsbn.where(isbn: isbn).length.positive?
  end
end
