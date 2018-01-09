class User < ApplicationRecord
  has_secure_password

  has_many :books, through: :reviews
  has_many :books, through: :genres
  has_many :books, through: :reading_lists

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_and_belongs_to_many :genres
  has_many :reviews
  has_many :reading_lists

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
end
