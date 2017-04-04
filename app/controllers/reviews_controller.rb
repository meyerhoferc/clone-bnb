class ReviewsController < ApplicationController
  def index
    listing_ids = current_user.reservations.where(status: "complete").map do |reservation|
      reservation.listing_id
    end
    @completed_trips = Listing.where(id: [listing_ids])
  end
end
