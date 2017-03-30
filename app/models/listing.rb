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
end
