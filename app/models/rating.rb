class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, uniqueness: true
end
