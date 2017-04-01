class Amenity < ApplicationRecord
  has_many :listing_amenities
  has_many :listings, through: :listing_amenities
end
