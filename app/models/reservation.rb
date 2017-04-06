class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, :end_date, :listing, :user, :status, presence: true
  enum status: [:pending, :confirmed, :complete, :cancelled]

  scope :complete, -> { where(status: 'complete') }

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

  def host_first_name
    listing.user.first_name
  end

  def host_last_name
    listing.user.last_name
  end

  def host_email
    listing.user.email
  end

  def host_phone
    listing.user.phone_number
  end

  def listing_name
    listing.title
  end

  def listing_address
    listing.street_address
  end

  def listing_category
    listing.list_category
  end

  def listing_city
    listing.city
  end
end
