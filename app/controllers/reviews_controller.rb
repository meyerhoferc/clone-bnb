class ReviewsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @completed_trips = user.reservations.where(status: "complete")

  end

  def show
    @listing = Listing.find(params[:listing_id])
    @review = Review.create!(review_params)
  end

  private

  def review_params
    params.require(:review).permit(:title, :stars, :message)
  end
end
