class Api::V1::Listings::CitiesController < ApplicationController
  def index
    render json: Listing.listings_per_city
  end
end
