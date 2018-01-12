class Genre < ApplicationRecord
  has_many :books
  has_many :interests
  has_many :users, through: :interests
end
