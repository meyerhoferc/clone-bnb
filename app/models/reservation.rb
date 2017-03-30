class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  enum status: [:pending, :confirmed, :complete, :cancelled]

  def num_nights
    (self.start_date..self.end_date).to_a.count
  end

  def unit_cost
    self.listing.cost_per_night
  end

  def total_cost
    self.num_nights * self.unit_cost
  end

end
