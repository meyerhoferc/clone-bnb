class HomeController < ApplicationController
  def index
    @listings = Listing.all.cities.uniq
    byebug
  end
end
