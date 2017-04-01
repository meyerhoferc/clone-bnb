class User::ListingsController < ApplicationController
  def index
    @listings = current_user.listings
  end

  def show
    @listing = Listing.find(params[:listing_id])
  end
end
