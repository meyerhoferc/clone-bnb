class TripsController < ApplicationController
  def index
    @trips = current_user.reservations
  end

  def show
  end
end
