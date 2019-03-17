class User < ApplicationRecord
  has_secure_password

  has_many :books, through: :reviews
  has_many :books, through: :genres
  has_many :books, through: :reading_lists
  has_many :active_relationships, class_name:  'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :interests
  has_many :genres, through: :interests
  has_many :reviews
  has_many :reading_lists
  has_many :ratings
  has_many :sent_conversations, class_name:  'Conversation',
                                foreign_key: 'sender_id',
                                dependent:   :destroy
  has_many :received_conversations, class_name:  'Conversation',
                                    foreign_key: 'recipient_id',
                                    dependent:   :destroy
  has_many :messages

  validates :username, :email, :password, :password_confirmation, presence: true
  validates :username, :email, uniqueness: true
  validates_length_of :password, :minimum => 8
  before_save :downcase_fields

  def downcase_fields
    username.downcase!
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # Returns a random book that the user has in their reading list
  def one_of_their_books
    reading_lists.sample.book
  end

  def self.users_to_follow(num_of_users, current_user)
    users_except_self = all.reject { |user| user == current_user }
    users_except_self.each_with_object([]) do |user, users|
      users << user
    end.sample(num_of_users)
  end

  def self.find_user(search)
    where(' username LIKE ? ', "%#{search}%")
  end
end
