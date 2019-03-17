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
    # First we check to see if the book in question has any ratings yet. If not, this returns 0 and a display will change in the book show view
    if !ratings.any?
      return false
    end

    # Then we obtain all of the ratings of the book in an array
    total_stars = 0
    ratings.each do |rating|
      rounded_rating = rating.stars.round
      total_stars += rounded_rating
    end

    # Get the average of all those values (total/ number of items)
    avg_stars = total_stars / ratings.length

    return avg_stars
  end

  def self.exists?(isbn)
    book = Book.find_by(isbn: isbn)
    return true if book
    false
  end
end
