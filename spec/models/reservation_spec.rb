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
end
