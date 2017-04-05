require 'rails_helper'

describe "Listings Record API" do
  describe "it can find listing(s)" do
    context "find all listings by an attribute" do
      it "can find listings by city case-insensitively" do
        denver_listings = Fabricate.times(4, :listing, city: "dEnVer", state: "CO")
        denver_listing_ids = denver_listings.map { |listing| listing.id }
        Fabricate(:listing, city: "Tucson", state: "AZ")

        get "/api/v1/listings/find_all?city=Denver"

        expect(response).to be_success
        listings = JSON.parse(response.body, symbolize_names: true)
        expect(listings.count).to eq(4)
        listing_ids = listings.map{ |listing| listing[:id] }
        listing_ids.each do |id|
          expect(id.in?(denver_listing_ids)).to be_truthy
        end
      end

      it "can find listings by title, number of bathrooms, and cost per night" do
        title_listing = Fabricate(:listing, number_baths: 0, cost_per_night: 10, title: "This")
        bathroom_listings = Fabricate.times(2, :listing, number_baths: 2, cost_per_night: 0)
        cost_listings = Fabricate.times(3, :listing, cost_per_night: 20, number_baths: 0)

        get "/api/v1/listings/find_all?title=#{title_listing.title}"

        expect(response).to be_success
        json_title_listings = JSON.parse(response.body, symbolize_names: true)
        expect(json_title_listings.count).to eq(1)
        expect(json_title_listings.first[:title]).to eq(title_listing.title)
        expect(json_title_listings.first[:id]).to eq(title_listing.id)

        get "/api/v1/listings/find_all?number_baths=2"

        expect(response).to be_success
        json_bathroom_listings = JSON.parse(response.body, symbolize_names: true)
        expect(json_bathroom_listings.count).to eq(2)
        expect(json_bathroom_listings.first[:id]).to eq(bathroom_listings.first.id)
        expect(json_bathroom_listings.last[:id]).to eq(bathroom_listings.last.id)

        get "/api/v1/listings/find_all?cost_per_night=20"

        expect(response).to be_success
        json_cost_listings = JSON.parse(response.body, symbolize_names: true)
        expect(json_cost_listings.count).to eq(3)
        expect(json_cost_listings.first[:id]).to eq(cost_listings.first.id)
        expect(json_cost_listings.last[:id]).to eq(cost_listings.last.id)
      end
    end

    context "find one listing by an attribute" do
      it "can find by title" do
        property = Fabricate(:listing, title: "Niiiice")
        title = property.title

        get "/api/v1/listings/find?title=#{title}"

        listing = JSON.parse(response.body)

        expect(response).to be_success
        expect(listing["title"]).to eq(title)
      end

      it "can find by street_address" do
        property = Fabricate(:listing, street_address: "123 Sycamore Ct")
        street_address = property.street_address

        get "/api/v1/listings/find?address=#{street_address}"

        listing = JSON.parse(response.body)

        expect(response).to be_success
        expect(listing["street_address"]).to eq(street_address)
      end
    end
  end
end
