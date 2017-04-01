require 'rails_helper'

describe "traveler can send a message" do
  it "when they are logged in" do
    listing_1 = Fabricate(:listing)
    image_1, image_2, image_3 = Fabricate.times(3, :image, listing: listing_1)

    traveler = Fabricate(:user)
    traveler.roles.create!(title: "traveler")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)
    visit "/listings/#{listing_1.id}"
    click_on "Message #{listing_1.user.first_name}"

    fill_in("message[body]", with: "Is it available?")
    click_on "Create Message"

    within(".card") do
      expect(page).to have_content("Messages between #{traveler.first_name} and #{listing_1.user.first_name}")
    end
    within(".card") do
      expect(page).to have_content("Is it available?")
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
