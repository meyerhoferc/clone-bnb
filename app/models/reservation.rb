class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, :end_date, :listing, :user, :status, presence: true
  enum status: [:pending, :confirmed, :complete, :cancelled]

  def no_overlapping?
    listing.present? && listing.range_available?(start_date, end_date)
  end
end
