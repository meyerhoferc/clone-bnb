require 'rails_helper'

describe Listing do
  describe "validations" do
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:max_occupancy) }
    it { should validate_presence_of(:number_beds) }
    it { should validate_presence_of(:number_rooms) }
    it { should validate_presence_of(:number_baths) }
  end

  describe "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:reservations) }
    it { should have_many(:images) }
    it { should have_many(:listing_amenities) }
    it { should have_many(:amenities) }
  end

  describe "#range_available?" do
    it "should determine if a listing has a reservation on a date" do
      listing = Fabricate(:listing)
      Fabricate.times(3, :image, listing: listing)
      traveler = Fabricate(:user)
      start_date = "01/01/2018"
      end_date = "04/01/2018"
      Reservation.create!(listing: listing,
                          user: traveler,
                          start_date: start_date,
                          end_date: end_date)

      expect(listing.range_available?(start_date, end_date)).to eq(false)
      expect(listing.date_available?(start_date)).to eq(false)
      expect(listing.date_available?(end_date)).to eq(false)
      expect(listing.range_available?("03/01/2018", "05/01/2018")).to eq(false)
      expect(listing.range_available?("02/01/2018", "03/01/2018")).to eq(false)
    end
  end

  describe "#most_vists(city, limit)" do
    it "returns an ordered list of listings for a city descending by total number of successful reservations" do
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
      listings = Listing.most_visits(city: "Denver", limit: "3")
      expect(listings.count).to eq(3)
      expect(listings.first.id).to eq(listing_one.id)
      expect(listings[1].id).to eq(listing_two.id)
      expect(listings.last.id).to eq(listing_three.id)
    end
  end
end
