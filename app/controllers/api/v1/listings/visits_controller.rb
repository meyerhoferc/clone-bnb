class Api::V1::Listings::VisitsController < ApplicationController
  def index
    render json: Listing.most_visits(listing_params)
  end

  private

  def listing_params
    params.permit(:city, :limit)
  end
end
