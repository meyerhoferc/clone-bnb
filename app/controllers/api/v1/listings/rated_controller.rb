class Api::V1::Listings::RatedController < ApplicationController

  def index
    render json: Listing.highest_rated(listing_params)
  end

  def show
    render json: Listing.listings_ranked_in_city(listing_city_params)
  end

  private

  def listing_params
    params.permit(:limit)
  end

  def listing_city_params
    params.permit(:city, :limit)
  end
end
