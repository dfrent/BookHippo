class Book < ApplicationRecord
  has_many :users, through: :reviews
  has_many :users, through: :reading_lists

  belongs_to :genre
  has_many :reviews
  has_many :reading_lists

  validates :isbn, uniqueness: true

  def self.find_or_api_call(isbn)
    book = Book.find_by(isbn: isbn)
    if book
      return book
    else
      book_response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn=#{isbn}&key=#{ENV['GBOOKS_KEY']}")

      book = book_response.parsed_response["items"][0]["volumeInfo"]

      Book.create(isbn: isbn, title: book["title"], author: book["authors"][0], description: book["description"], book_cover: book["imageLinks"]["thumbnail"], genre_id: 1)
    end
  end
end
