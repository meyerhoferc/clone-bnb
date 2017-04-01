require 'rails_helper'

describe "traveler can send a message" do
  context "with proper credentials" do
    it "when they visit their dashboard" do
      traveler = Fabricate(:user)
      traveler.roles.create!(title: "traveler")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)
      visit dashboard_path

      click_on
    end
  end

  context "without proper credentials" do
    xit "they cannot see other users messages" do

    end
  end
end

describe "host can send a message" do
  xcontext "with proper credentials" do
    it "when they visit their dashboard" do
      host = Fabricate(:user)
      traveler.roles.create!(title: "host")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)
      visit dashboard_path
    end
  end

  context "without proper credentials" do
    xit "they cannot see other users messages" do

    end
  end
end
