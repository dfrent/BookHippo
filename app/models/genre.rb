class Genre < ApplicationRecord
  has_many :books
  has_many :interests
  has_and_belongs_to_many :users, through: :interests
end
