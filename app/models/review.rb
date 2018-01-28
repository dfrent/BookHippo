class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :comment, presence: true

  def review_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  def username_display
    return user.username.capitalize
  end
end
