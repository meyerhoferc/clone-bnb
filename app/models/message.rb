class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  # validates: :body, :conversation_id, :user_id, presence: true
end
