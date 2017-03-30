class ReservationsController < ApplicationController
  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.update_attributes(status: "pending", user_id: current_user.id)
    if @reservation.save
      flash[:success] = "Successfully made reservation"
      redirect_to reservation_path(@reservation)
    else
      flash[:danger] = "Reservation not created, check that the dates are entered correctly"
      render :new
    end
  end

  def show
    byebug
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
