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
end
