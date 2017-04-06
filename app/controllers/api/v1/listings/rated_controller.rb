class Api::V1::Listings::RatedController < ApplicationController
  def index
    render json: Listing.highest_rated(listing_params)
  end

  private

  def listing_params
    params.permit(:limit)
  end
end
