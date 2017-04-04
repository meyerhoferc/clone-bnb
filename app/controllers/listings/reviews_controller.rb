class Listings::ReviewsController < ApplicationController
  def new

  end

  def create
    @listing = Listing.find(params[:listing_id])
    @review = @listing.reviews.new(review_params)
    if @review.save
      redirect_to listing_path(@listing)
      flash[:sucess] = "You have successfully submitted a review!"
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :stars, :message)
  end
end
