class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, :end_date, :listing, :user, :status, presence: true
  enum status: [:pending, :confirmed, :complete, :cancelled]
end
