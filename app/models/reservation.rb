class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, :end_date, :listing, :user, :status, presence: true
  enum status: [:pending, :confirmed, :complete, :cancelled]

  def num_nights
    (self.start_date..self.end_date).to_a.count - 1
  end

  def unit_cost
    self.listing.cost_per_night
  end

  def total_cost
    (self.num_nights) * (self.unit_cost)
  end

  def no_overlapping?
    listing.present? && listing.range_available?(start_date, end_date)
  end

end
