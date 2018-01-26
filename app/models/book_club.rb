class BookClub < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :users, through: :chats
  belongs_to :user
  belongs_to :book
  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: true, case_sensitive: false

end
