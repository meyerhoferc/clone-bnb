class TripsController < ApplicationController
  def index
    @trips = current_user.reservations
  end

  def show
    @reservation = Reservation.find(params[:id])
  end
end
