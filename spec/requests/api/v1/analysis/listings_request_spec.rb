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

  describe "ranking cities by most visited" do
    it "for all successful reservations" do
      cities = {"Denver" => 3, "Santa Fe" => 1, "Seattle" => 0}
      allow(Listing).to receive(:most_visited_cities).and_return(cities)
      get "/api/v1/cities/most_visited"

      expect(response).to be_success
      json_cities = JSON.parse(response.body)
      expect(json_cities.count).to eq(3)
      expect(json_cities.keys.first).to eq("Denver")
      expect(json_cities.keys.last).to eq("Seattle")
    end
  end

  describe "display cities with number of listings" do
    it "in each city" do
      listing_one, listing_two, listing_three = Fabricate.times(3, :listing, city: "Denver", state: "CO")
      Fabricate.times(2, :listing, city: "Tucson", state: "AZ")
      cities_hash = {"Tucson" => 2, "Denver" => 3}
      allow(Listing).to receive(:listings_per_city).and_return(cities_hash)
      get "/api/v1/listings/listings_per_city"

      expect(response).to be_success
      json_cities = JSON.parse(response.body)
      expect(json_cities.count).to eq(2)

      expect(json_cities).to include("Tucson"=>2)
      expect(json_cities).to include("Denver"=>3)
    end
  end

  describe "displays highest rated listings" do
    it "with a given limit" do
      listing_one, listing_two, listing_three = Fabricate.times(3, :listing, city: "Denver", state: "CO")
      allow(Listing).to receive(:highest_rated).and_return([listing_one, listing_two, listing_three])
      get "/api/v1/listings/highest_rated?limit=3"

      expect(response).to be_success
      json_listing = JSON.parse(response.body)

      expect(json_listing.count).to eq(3)
      expect(json_listing[0]["id"]).to eq(listing_one.id)
      expect(json_listing[1]["id"]).to eq(listing_two.id)
      expect(json_listing[2]["id"]).to eq(listing_three.id)
    end
  end

  describe "ranks listings by highest rated in a given city" do
    it "returns them in order of descending average rankings" do
      listing_one, listing_two, listing_three = Fabricate.times(3, :listing, city: "Denver", state: "CO")
      allow(Listing).to receive(:listings_ranked_in_city).and_return([listing_one, listing_two, listing_three])
      get "/api/v1/listings/highest_rated_by_city?city=Denver&limit=3"

      expect(response).to be_success
      json_listings = JSON.parse(response.body, symbolize_names: true)
      expect(json_listings.count).to eq(3)
      expect(json_listings.first[:id]).to eq(listing_one.id)
      expect(json_listings.last[:id]).to eq(listing_three.id)
    end
  end
end
