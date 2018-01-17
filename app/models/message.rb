class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  def self.read_message(message)
    message.read = true
  end

end
