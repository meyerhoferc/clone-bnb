class ReviewsController < ApplicationController
  def index
    listing_ids = current_user.reservations.where(status: "complete").map do |reservation|
      reservation.listing_id
    end
    @completed_trips = Listing.where(id: [listing_ids])
  end

  def new
    @review = Review.new
  end

  def create
    #byebug
    #@listing = Listing.find(params[:listing_id])
    @review = Review.new(review_params)
    @review.listing_id = params[:listing_id]
    if @review.save
      redirect_to user_reviews_path(current_user)
      flash[:notice] = "You've successully submited a review"
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :stars, :message)
  end
end
