require 'rails_helper'

describe Conversation do
  describe "validations" do
    it { should validate_uniqueness_of(:initiator_id) }
  end

  describe "relationships" do
    it { should belong_to(:initiator) }
    it { should belong_to(:recipient) }
    it { should have_many(:messages) }
  end
end
