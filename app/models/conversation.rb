class Conversation < ApplicationRecord
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validate :sender_is_not_recipient

  scope :between, ->(sender_id, recipient_id) do
    where('(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)', sender_id, recipient_id, recipient_id, sender_id)
  end

  def sender_is_not_recipient
    if sender == recipient
      errors.add(:base, 'Sender cannot be the same user as recipient.')
    end
  end
end
