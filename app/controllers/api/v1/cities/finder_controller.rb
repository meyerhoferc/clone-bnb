class Api::V1::Cities::FinderController < ApplicationController
  def show
    render json: Listing.most_visited_cities
  end
end
