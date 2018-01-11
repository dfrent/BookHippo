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
      authors = book["authors"]
      authors_string = authors.join(", ")
      google_id = book_response.parsed_response["items"][0]["id"]

      Book.create(isbn: isbn, title: book["title"], author: authors_string, description: book["description"], book_cover: book["imageLinks"]["thumbnail"], small_thumbnail: book["imageLinks"]["smallThumbnail"], genre_id: 1, google_id: google_id, page_count: book["pageCount"], average_rating: book["averageRating"], published_date: book["publishedDate"], publisher: book["publisher"])
    end
  end
end
