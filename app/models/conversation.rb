class Conversation < ApplicationRecord
  belongs_to :initiator, foreign_key: :initiator_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  has_many :messages, dependent: :destroy
  validates: :initiator_id, scope: :recipient_id, uniqueness: true
  scope :between, -> (initiator_id,recipient_id) do
    where("(conversations.initiator_id = ? AND conversations.recipient_id =?)
    OR (conversations.initiator_id = ? AND conversations.recipient_id =?)",
    initiator_id, recipient_id, recipient_id, initiator_id)
  end
end
