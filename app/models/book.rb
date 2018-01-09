class Book < ApplicationRecord
  has_many :users, through: :reviews
  has_many :users, through: :reading_lists

  belongs_to :genre
  has_many :reviews
  has_many :reading_lists

  def self.find_or_api_call(isbn)
    book = Book.find_by(isbn: isbn)
    if book
      return book
    else
      book = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn=#{isbn}&key=#{ENV['GBOOKS_KEY']}")
      Book.create(title: isbn)
    end

  end




end
