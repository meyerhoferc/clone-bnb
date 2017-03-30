class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  enum status: [:pending, :confirmed, :complete, :cancelled]
end
