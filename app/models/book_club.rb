class BookClub < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  belongs_to :user
  belongs_to :book
  has_and_belongs_to_many :users


  validates :name, presence: true, uniqueness: true, case_sensitive: false

end
