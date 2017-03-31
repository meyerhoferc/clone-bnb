class ReservationsController < ApplicationController
  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = @listing.reservations.new(reservation_params)
    @reservation.user = current_user
    if @reservation.no_overlapping? && @reservation.save
      flash[:success] = "Successfully made reservation"
      redirect_to reservation_path(@reservation)
    else
      flash[:danger] = "Reservation not created. Please select another date range."
      render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def index
    @reservations = Reservation.all
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
