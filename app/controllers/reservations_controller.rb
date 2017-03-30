class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    byebug
  end
end
