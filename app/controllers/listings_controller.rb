class ListingsController < ApplicationController
  def index
    @listings = Listing.page(params[:page])
  end

  def show
    @listing = Listing.find(params[:id])
    @reservation_listing = @listing.user_stayed_at?(current_user)
    render file: "public/404" unless @listing.user.status == "active"
  end
end
