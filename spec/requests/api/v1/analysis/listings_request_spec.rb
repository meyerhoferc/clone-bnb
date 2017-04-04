require 'rails_helper'

describe "Listings Analysis API" do
  describe "ranking listings by most visited" do
    it "for a city" do
      user = User.create!(email: "email@email.com",
                          first_name: "Castle",
                          last_name: "Pines",
                          about_me: "Boop beep boop",
                          phone_number: "853-343-2343",
                          password: "123")
      user.roles.create!(title: "traveler")

      listing_one, listing_two, listing_three = Fabricate.times(3, :listing, city: "Denver", state: "CO")
      Fabricate.times(2, :listing, city: "Tucson", state: "AZ")

      Reservation.create!(listing: listing_one,
                          user: user,
                          start_date: "01/01/2018",
                          end_date: "04/01/2018")
      Reservation.create!(listing: listing_one,
                          user: user,
                          start_date: "01/02/2018",
                          end_date: "04/02/2018")
      Reservation.create!(listing: listing_one,
                          user: user,
                          start_date: "01/03/2018",
                          end_date: "04/03/2018")

      Reservation.create!(listing: listing_two,
                          user: user,
                          start_date: "01/01/2019",
                          end_date: "04/01/2019")
      Reservation.create!(listing: listing_two,
                          user: user,
                          start_date: "01/02/2019",
                          end_date: "04/02/2019")

      Reservation.create!(listing: listing_three,
                          user: user,
                          start_date: "01/02/2020",
                          end_date: "04/02/2020")

      get "/api/v1/listings/most_visited?city=Denver&limit=3"

      expect(response).to be_success
      listings = JSON.parse(response.body, symbolize_names: true)
      expect(listings.count).to eq(3)
      expect(listings.first[:id]).to eq(listing_one.id)
      expect(listings[1][:id]).to eq(listing_two.id)
      expect(listings.last[:id]).to eq(listing_three.id)
    end
  end
end
