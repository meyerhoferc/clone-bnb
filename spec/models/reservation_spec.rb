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
end
