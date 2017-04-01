class Conversation < ApplicationRecord
  belongs_to :initiator, class_name: 'User', foreign_key: 'initiator_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  has_many :messages, dependent: :destroy
  validates_uniqueness_of :initiator_id, :scope => :recipient_id
  scope :between, -> (initiator_id,recipient_id) do
    where("(conversations.initiator_id = ? AND conversations.recipient_id = ?)
    OR (conversations.initiator_id = ? AND conversations.recipient_id = ?)",
    initiator_id, recipient_id, recipient_id, initiator_id)
  end
end
