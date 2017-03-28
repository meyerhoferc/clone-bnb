class Message < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: :host_id
  belongs_to :traveler, class_name: 'User', foreign_key: :traveler_id
end
