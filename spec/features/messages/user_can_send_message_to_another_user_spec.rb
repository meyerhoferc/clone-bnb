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

  it "they cannot send messages if not logged in" do
    listing_1 = Fabricate(:listing)
    image_1, image_2, image_3 = Fabricate.times(3, :image, listing: listing_1)

    visit "/listings/#{listing_1.id}"

    expect(page).to_not have_content("Message #{listing_1.user.first_name}")
  end

end
