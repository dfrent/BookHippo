class BookClub < ApplicationRecord
  has_many :chats, dependent: :destroy
  belongs_to :user
  belongs_to :book
  has_many :subscriptions
  has_many :users, through: :subscriptions

  validates :name, presence: true, uniqueness: true, case_sensitive: false

end
