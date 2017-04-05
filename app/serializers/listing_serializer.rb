class ListingSerializer < ActiveModel::Serializer
  attributes :id,
             :street_address,
             :city,
             :state,
             :zipcode,
             :description,
             :title,
             :max_occupancy,
             :list_category,
             :number_beds,
             :number_rooms,
             :number_baths,
             :cost_per_night
  has_many :reservations
end
