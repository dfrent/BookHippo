class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :stars, presence: true
end
