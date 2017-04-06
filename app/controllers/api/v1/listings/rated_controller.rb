class Api::V1::Listings::RatedController < ApplicationController
  def index
    byebug
    render json: Listing.highest_rated(listing_params)
  end

  private

  def listing_params
    params.require(:listing).permit(:limit)
  end
end
