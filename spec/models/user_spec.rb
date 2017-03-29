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

  describe "#traveler?" do
    it "returns true if a user has a traveler role" do
      user_one = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
      user_one.roles.create(title: "traveler")

      user_two = User.create(email: "other_email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
      user_two.roles.create(title: "host")

      user_three = User.create(email: "other@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
      user_three.roles.create(title: "admin")

      user_four = User.create(email: "another@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
      user_four.roles.create(title: "admin")
      user_four.roles.create(title: "traveler")
      user_four.roles.create(title: "host")

      expect(user_one.traveler?).to eq(true)
      expect(user_two.traveler?).to eq(false)
      expect(user_three.traveler?).to eq(false)
      expect(user_four.traveler?).to eq(true)
    end
  end
end
