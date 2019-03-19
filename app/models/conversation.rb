class Conversation < ApplicationRecord
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validate :sender_is_not_recipient

  def sender_is_not_recipient
    errors.add(:base, 'Sender cannot be the same user as recipient.') if sender == recipient
  end
end
