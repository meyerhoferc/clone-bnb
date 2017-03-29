require 'rails_helper'

describe User do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:phone_number) }
  end

  describe "relationships" do
    it { should have_many(:listings) }
    it { should have_many(:reservations) }
    it { should have_many(:user_roles) }
    it { should have_many(:roles) }
  end

end
