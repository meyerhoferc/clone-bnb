require 'rails_helper'

describe Amenity do
  describe "relationships" do
    it { should have_many(:listing_amenities) }
    it { should have_many(:listings) }
  end
end
