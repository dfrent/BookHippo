# frozen_string_literal: true

# Books are collections of real world book data
# pulled from the google books API
class Book < ApplicationRecord
  has_many :users, through: :reviews
  has_many :users, through: :reading_lists

  belongs_to :genre
  has_many :reviews
  has_many :reading_lists
  has_many :ratings
  has_many :book_clubs

  validates :isbn, uniqueness: true
  validates :isbn, :author, :title, :book_cover, :description, presence: true

  def average_rating
    return false unless ratings.any?

    total_stars = ratings.inject(0) do |total, rating|
      rounded_rating = rating.stars.round
      total + rounded_rating
    end

    total_stars / ratings.length
  end

  def self.exists?(isbn)
    book = Book.find_by(isbn: isbn)
    return true if book
    false
  end
end
