class User < ApplicationRecord
  has_secure_password

  has_many :books, through: :reviews
  has_many :books, through: :genres
  has_many :books, through: :reading_lists

  has_and_belongs_to_many :genres
  has_many :reviews
  has_many :reading_lists
end
