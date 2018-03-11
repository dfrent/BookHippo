# frozen_string_literal: true

# A genre represents a collection of books of a similar topic
class Genre < ApplicationRecord
  has_many :books
  has_many :interests
  has_many :users, through: :interests

  validates :name, presence: true
  validates :name, uniqueness: true
end
