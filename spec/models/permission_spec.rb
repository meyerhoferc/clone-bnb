require 'rails_helper'

describe Permission do
  describe "#guest_user_permissions" do
    it "allows a guest to interact with sessions controller" do
      allow_any_instance_of(Permission).to receive(:controller).and_return("sessions")
      permission = Permission.new(nil)
      expect(permission.guest_user_permissions).to eq(true)
    end

    it "allows a guest to interact with home controller" do
      allow_any_instance_of(Permission).to receive(:controller).and_return("home")
      permission = Permission.new(nil)
      expect(permission.guest_user_permissions).to eq(true)
    end

    it "allows a guest to interact with users controller" do
      allow_any_instance_of(Permission).to receive(:controller).and_return("users")
      permission = Permission.new(nil)
      expect(permission.guest_user_permissions).to eq(true)
    end

    it "does not allow a guest to interact with dashboard controller" do
      allow_any_instance_of(Permission).to receive(:controller).and_return("dashboard")
      permission = Permission.new(nil)
      expect(permission.guest_user_permissions).to eq(nil)
    end
  end

  describe "#traveler_user_permissions" do
    it "allows a traveler to interact with the sessions controller" do
      user = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
      user.roles.new(title: "traveler")
      allow_any_instance_of(Permission).to receive(:controller).and_return("sessions")
      permission = Permission.new(user)
      expect(permission.traveler_user_permissions).to eq(true)
    end

    it "allows a traveler to interact with the home controller" do
      user = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
      user.roles.new(title: "traveler")
      allow_any_instance_of(Permission).to receive(:controller).and_return("home")
      permission = Permission.new(user)
      expect(permission.traveler_user_permissions).to eq(true)
    end

    it "allows a traveler to interact with the users controller" do
      user = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
      user.roles.new(title: "traveler")
      allow_any_instance_of(Permission).to receive(:controller).and_return("users")
      permission = Permission.new(user)
      expect(permission.traveler_user_permissions).to eq(true)
    end

    it "allows a traveler to interact with the dashboard controller" do
      user = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
      user.roles.new(title: "traveler")
      allow_any_instance_of(Permission).to receive(:controller).and_return("dashboard")
      permission = Permission.new(user)
      expect(permission.traveler_user_permissions).to eq(true)
    end
  end
end
