# frozen_string_literal: true

# A book club is a group of users who can discuss
# books, chosen by admin, to discuss in a live
# chatroom
class BookClub < ApplicationRecord
  has_many :chats, dependent: :destroy
  belongs_to :user
  belongs_to :book
  has_many :subscriptions
  has_many :users, through: :subscriptions

  validates :name, presence: true, uniqueness: true, case_sensitive: false
end
