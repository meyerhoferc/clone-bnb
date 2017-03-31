class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  # before_save :overlapping_reservations

  validates :start_date, :end_date, :listing, :user, :status, presence: true
  enum status: [:pending, :confirmed, :complete, :cancelled]

  def no_overlapping?
    # byebug
    # if listing.present? && listing.range_available?(start_date, end_date) == false
    #   errors.add(:start_date, "already exists")
    # end
    listing.present? && listing.range_available?(start_date, end_date)
  end
end
