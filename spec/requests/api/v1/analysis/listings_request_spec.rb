require 'rails_helper'

describe "Listings Analysis API" do
  describe "ranking listings by most visited in a city" do
    it "for a city" do
      listing_one, listing_two, listing_three = Fabricate.times(3, :listing, city: "Denver", state: "CO")
      Fabricate.times(2, :listing, city: "Tucson", state: "AZ")
      allow(Listing).to receive(:most_visits).and_return([listing_one, listing_two, listing_three])

      get "/api/v1/listings/most_visited?city=Denver&limit=3"

      expect(response).to be_success
      listings = JSON.parse(response.body, symbolize_names: true)
      expect(listings.count).to eq(3)
      expect(listings.first[:id]).to eq(listing_one.id)
      expect(listings[1][:id]).to eq(listing_two.id)
      expect(listings.last[:id]).to eq(listing_three.id)
    end
  end

  describe "ranking listings by most visited" do
    it "across all locations" do
      listing_one, listing_two, listing_three, listing_four = Fabricate.times(4, :listing)
      allow(Listing).to receive(:most_visits_all).and_return([listing_one, listing_two, listing_three])

      get "/api/v1/listings/most_visited_all?limit=3"
      expect(response).to be_success
      listings = JSON.parse(response.body, symbolize_names: true)
      expect(listings.count).to eq(3)
      expect(listings.first[:id]).to eq(listing_one.id)
      expect(listings[1][:id]).to eq(listing_two.id)
      expect(listings.last[:id]).to eq(listing_three.id)
    end
  end
end
