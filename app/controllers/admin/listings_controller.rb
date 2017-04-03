class Admin::ListingsController < ApplicationController

  def index
    @listings = Listing.all
  end

  def show
    @listings = Listing.find(params[:id])
  end

  def delete
  end

end
