class Api::V1::Listings::VisitsController < ApplicationController
  def show
    render json: Listing.most_visits(listing_params)
  end

  def index
    render json: Listing.most_visits_all(listing_params)
  end

  private

  def listing_params
    params.permit(:city, :limit)
  end
end
