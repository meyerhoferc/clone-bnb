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
    it { should have_many(:user_roles) }
    it { should have_many(:reservations) }
    it { should have_many(:images) }
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
end
