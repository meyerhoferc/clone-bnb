require 'rails_helper'

describe "Listings Record API" do
  describe "it can find listing(s)" do
    context "find all listings by an attribute" do
      it "can find listings by city case-insensitively" do
        denver_listings = Fabricate.times(4, :listing, city: "dEnVer", state: "CO")
        denver_listing_ids = denver_listings.map { |listing| listing.id }
        Fabricate(:listing, city: "Tucson", state: "AZ")
        allow(Listing).to receive(:where).and_return(denver_listings)
        get "/api/v1/listings/find_all?city=Denver"

        expect(response).to be_success
        listings = JSON.parse(response.body, symbolize_names: true)
        expect(listings.count).to eq(4)
        listing_ids = listings.map{ |listing| listing[:id] }
        listing_ids.each do |id|
          expect(id.in?(denver_listing_ids)).to be_truthy
        end
      end

      it "can find listings by title" do
        title_listing = Fabricate(:listing, number_baths: 0, cost_per_night: 10, title: "This")
        bathroom_listings = Fabricate.times(2, :listing, number_baths: 2, cost_per_night: 0)
        cost_listings = Fabricate.times(3, :listing, cost_per_night: 20, number_baths: 0)
        allow(Listing).to receive(:where).and_return([title_listing])
        get "/api/v1/listings/find_all?title=#{title_listing.title}"

        expect(response).to be_success
        json_title_listings = JSON.parse(response.body, symbolize_names: true)
        expect(json_title_listings.count).to eq(1)
        expect(json_title_listings.first[:title]).to eq(title_listing.title)
        expect(json_title_listings.first[:id]).to eq(title_listing.id)
      end

      it "can find listings by number of bathrooms" do
        title_listing = Fabricate(:listing, number_baths: 0, cost_per_night: 10, title: "This")
        bathroom_listings = Fabricate.times(2, :listing, number_baths: 2, cost_per_night: 0)
        cost_listings = Fabricate.times(3, :listing, cost_per_night: 20, number_baths: 0)
        allow(Listing).to receive(:where).and_return(bathroom_listings)
        get "/api/v1/listings/find_all?number_baths=2"

        expect(response).to be_success
        json_bathroom_listings = JSON.parse(response.body, symbolize_names: true)
        expect(json_bathroom_listings.count).to eq(2)
        expect(json_bathroom_listings.first[:id]).to eq(bathroom_listings.first.id)
        expect(json_bathroom_listings.last[:id]).to eq(bathroom_listings.last.id)
      end

      it "can find listings by cost per night" do
        title_listing = Fabricate(:listing, number_baths: 0, cost_per_night: 10, title: "This")
        bathroom_listings = Fabricate.times(2, :listing, number_baths: 2, cost_per_night: 0)
        cost_listings = Fabricate.times(3, :listing, cost_per_night: 20, number_baths: 0)
        allow(Listing).to receive(:where).and_return(cost_listings)
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
        allow(Listing).to receive(:find_by).and_return(property)
        get "/api/v1/listings/find?title=#{title}"

        listing = JSON.parse(response.body)

        expect(response).to be_success
        expect(listing["title"]).to eq(title)
      end

      it "can find by street_address" do
        property = Fabricate(:listing, street_address: "123 Sycamore Ct")
        street_address = property.street_address
        allow(Listing).to receive(:find_by).and_return(property)
        get "/api/v1/listings/find?address=#{street_address}"

        listing = JSON.parse(response.body)

        expect(response).to be_success
        expect(listing["street_address"]).to eq(street_address)
      end
    end
  end

  describe "highest_rated" do
    it "returns a given limit of listings with the highest rated listing" do
      user = User.create!(email: "email@email.com",
                     first_name: "Castle",
                      last_name: "Pines",
                       about_me: "Boop beep boop",
                   phone_number: "853-343-2343",
                       password: "123")
      user.roles.create!(title: "traveler")

      listing_one = Fabricate(:listing, city: "Denver")
      listing_two = Fabricate(:listing, city: "Denver")
      listing_three = Fabricate(:listing, city: "Denver")

      Fabricate.times(2, :listing, city: "Tucson", state: "AZ")

      3.times do
        Review.create!(title: "nice title",
                       message: "this is the thing",
                       stars: 3,
                       listing: listing_one)
      end

      3.times do
        Review.create!(title: "nice title",
                       message: "this is the thing",
                       stars: 4,
                       listing: listing_two)
      end

      3.times do
        Review.create!(title: "nice title",
                       message: "this is the thing",
                       stars: 5,
                       listing: listing_three)
      end

      Review.create!(title: "Nice", message: "message", stars: 1, listing: listing_one)
      Review.create!(title: "Nice", message: "message", stars: 1, listing: listing_two)
      Review.create!(title: "Nice", message: "message", stars: 1, listing: listing_three)

      params = {limit: 3 }
      final_listing = Listing.highest_rated(params)
      expect(final_listing.to_a.count).to eq(3)
      expect(final_listing.first.id).to eq(listing_three.id)
      expect(final_listing.last.id).to eq(listing_one.id)
    end
  end
end
