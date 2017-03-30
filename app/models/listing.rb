class Listing < ApplicationRecord
  has_many :images
  has_many :reservations
  has_many :user_roles
  belongs_to :user

  validates_presence_of :street_address,
                        :description,
                        :city,
                        :state,
                        :zipcode,
                        :user,
                        :max_occupancy,
                        :number_beds,
                        :number_rooms,
                        :number_baths

  def range_available?(start_date, end_date)
    reservations.where(start_date: start_date).count == 0 && reservations.where(end_date: end_date).count == 0
  end

  def date_available?(date)
  end
end
