require 'rails_helper'

describe Reservation do
  describe "validations" do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:listing) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:status) }
  end

  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:listing) }
  end

  describe "self.complete" do
    it "returns only reservations with a status of complete" do
      listing = Fabricate(:listing)
      user = Fabricate(:user)
      reservation_one = Reservation.create!(listing: listing,
                                            user: user,
                                            start_date: "01/02/2021",
                                            end_date: "04/02/2021",
                                            status: "complete")
      reservation_two = Reservation.create!(listing: listing,
                                            user: user,
                                            start_date: "01/02/2020",
                                            end_date: "04/02/2020",
                                            status: "pending")
      reservations = Reservation.complete
      expect(reservations.count).to eq(1)
      expect(reservations.first.id).to eq(reservation_one.id)
    end
  end

  describe "#host_first_name" do
    it "returns the first name of the host" do
      listing = Fabricate(:listing)
      user = Fabricate(:user, first_name: "Hi")
       Reservation.create!(listing: listing,
                           user: user,
                           start_date: "01/02/2020",
                           end_date: "04/02/2020",
                           status: "pending")
      expect(Reservation.last.host_first_name).to eq("Hi")
    end
  end

  describe "#host_last_name" do
    it "returns the last name of the host" do
      listing = Fabricate(:listing)
      user = Fabricate(:user, last_name: "Hi")
       Reservation.create!(listing: listing,
                           user: user,
                           start_date: "01/02/2020",
                           end_date: "04/02/2020",
                           status: "pending")
      expect(Reservation.last.host_last_name).to eq("Hi")
    end
  end

  describe "#host_email" do
    it "returns the host's email" do
      listing = Fabricate(:listing)
      user = Fabricate(:user, email: "hi@email.com")
       Reservation.create!(listing: listing,
                           user: user,
                           start_date: "01/02/2020",
                           end_date: "04/02/2020",
                           status: "pending")
      expect(Reservation.last.host_email).to eq("hi@email.com")
    end
  end

  describe "#listing_name" do
    it "returns the title for the listing" do
      listing = Fabricate(:listing, title: "TITLE")
      user = Fabricate(:user, email: "hi@email.com")
       Reservation.create!(listing: listing,
                           user: user,
                           start_date: "01/02/2020",
                           end_date: "04/02/2020",
                           status: "pending")
      expect(Reservation.last.listing_name).to eq("TITLE")
    end
  end

  describe "#listing_address" do
    it "returns the street address for the listing" do
      listing = Fabricate(:listing, street_address: "123 Street")
      user = Fabricate(:user, email: "hi@email.com")
       Reservation.create!(listing: listing,
                           user: user,
                           start_date: "01/02/2020",
                           end_date: "04/02/2020",
                           status: "pending")
      expect(Reservation.last.listing_address).to eq("123 Street")
    end
  end

  describe "#listing_category" do
    it "returns the type of property" do
      listing = Fabricate(:listing, list_category: "Entire House")
      user = Fabricate(:user, email: "hi@email.com")
       Reservation.create!(listing: listing,
                           user: user,
                           start_date: "01/02/2020",
                           end_date: "04/02/2020",
                           status: "pending")
      expect(Reservation.last.listing_category).to eq("Entire House")
    end
  end

  describe "#listing_city" do
    it "returns the city for the reservation's property" do
      listing = Fabricate(:listing, city: "Tucson")
      user = Fabricate(:user, email: "hi@email.com")
       Reservation.create!(listing: listing,
                           user: user,
                           start_date: "01/02/2020",
                           end_date: "04/02/2020",
                           status: "pending")
      expect(Reservation.last.listing_city).to eq("Tucson")
    end
  end
end
