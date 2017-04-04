class Api::V1::Listings::FinderController < ApplicationController

  def show
    render json: Listing.find_by(find_listings_params)
  end

  def find_listings_params
    params.permit(:id,
                  :user_id,
                  :street_address,
                  :description,
                  :city,
                  :state,
                  :zipcode,
                  :max_occupancy,
                  :title,
                  :list_category,
                  :cost_per_night,
                   )
  end
end
