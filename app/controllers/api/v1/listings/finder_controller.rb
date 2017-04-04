class Api::V1::Listings::FinderController < ApplicationController
  def index
    render json: Listing.where(listing_params)
  end

  private

  def listing_params
    params.permit(:city,
                  :id,
                  :street_address,
                  :state,
                  :zipcode,
                  :description,
                  :title,
                  :max_occupancy,
                  :list_category,
                  :number_beds,
                  :number_rooms,
                  :number_baths,
                  :cost_per_night)
  end
end
