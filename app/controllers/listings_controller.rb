class ListingsController < ApplicationController
  def index
    @listings = Listing.page(params[:page])
  end

  def show
    @listing = Listing.find(params[:id])
    render file: "public/404" unless @listing.user.status == "active"
  end
end
