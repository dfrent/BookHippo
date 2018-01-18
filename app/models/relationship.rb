class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validate :follower_is_not_followed

  def follower_is_not_followed
    if follower == followed
      errors.add(:base, "You cannot follow yourself")
    end
  end
end
