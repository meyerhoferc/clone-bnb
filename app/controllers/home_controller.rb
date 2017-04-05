class HomeController < ApplicationController
  def index
    @listings = Listing.all.cities.uniq
  end
end
