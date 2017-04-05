class HomeController < ApplicationController
  def index
<<<<<<< Updated upstream
    @listings = Listing.all.cities.uniq
=======
    @listings = Listing.select(:city).distinct.order('city ASC')
  end

  def show
    # byebug
    @city = params[:format]
    @listings_by_city = Listing.list_by_city(params[:format])
>>>>>>> Stashed changes
  end
end
