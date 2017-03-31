require 'rails_helper'

describe ListingAmenity do
  describe "relationships" do
    it { should belong_to(:listing) }
    it { should belong_to(:amenity) }
  end
end
