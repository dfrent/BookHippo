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

  def self.book_selector(isbn)
    book = Book.find_by(isbn: isbn)
    return book if book
  end

  def self.api_call(isbn)
    book_response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn=#{isbn}&key=#{ENV['GBOOKS_KEY']}")
    book = book_response.parsed_response['items'][0]
    return book if book_response
  end

  def self.new_book_data(isbn)
    book = Book.api_call(isbn)
    book_volume_info = book['volumeInfo']
    authors = book['authors'] if book
    authors_string = authors.join(', ') if authors
    google_id = book['id']
    book_data = { title: book_volume_info['title'],
                  author: authors_string,
                  description: book_volume_info['description'],
                  genre_id: 20,
                  google_id: google_id,
                  page_count: book_volume_info['pageCount'],
                  average_rating: book_volume_info['averageRating'],
                  published_date: book_volume_info['publishedDate'],
                  publisher: book_volume_info['publisher'] }
    return book_data
  end

  def self.find_or_api_call(isbn)
    book = Book.book_selector(isbn)
    return book if !book.nil?
    book = Book.new_book_data(isbn) if book.nil?
    return book if !book.nil?
    if book.nil?
      return 'Book not found'
    end
  end

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
    if book
      return book
    end
  end
end
