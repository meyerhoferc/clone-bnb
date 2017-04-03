class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
    render file: "public/404" unless @listing.user.status == "active"
  end
end
