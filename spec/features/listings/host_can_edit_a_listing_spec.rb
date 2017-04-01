require 'rails_helper'

describe "as a logged in host" do
  it "I can edit my listings" do
    user = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    user.roles.create!(title: "host")

    listing_one = Fabricate(:listing, user: user, title: "Big House")
    listing_two = Fabricate(:listing, user: user, title: "Small Apartment")
    listing_three = Fabricate(:listing, user: user, title: "Hipster Loft")

    Fabricate.times(3, :image, listing: listing_two)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_listing_path(user, listing_two)

    click_on "Edit"

    expect(current_path).to eq(edit_user_listing_path(user, listing_two))

    fill_in("listing[title]", with: "Large Apartment")
    fill_in("listing[max_occupancy]", with: "11")
    fill_in("listing[number_rooms]", with: "4")
    fill_in("listing[cost_per_night]", with: "45")

    click_on "Update Listing"

    expect(current_path).to eq(user_listing_path(user, listing_two))

    expect(page).to have_content("Large Apartment")
    expect(page).to have_content("$45")
    expect(page).to have_content("Number of Rooms: 4")
    expect(page).to have_content("Maximum Occupancy: 11")
  end
end
