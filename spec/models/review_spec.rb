require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:stars) }
  end

  describe "relationships" do
    it { should belong_to(:listing) }
  end
end
