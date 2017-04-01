require 'rails_helper'

describe "a logged in host user" do
  it "they can see all of their listings from their dashboard sidebar link" do
    user = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    user.roles.create!(title: "host")

    listing_one = Fabricate(:listing, user: user, title: "Big House")
    listing_two = Fabricate(:listing, user: user, title: "Small Apartment")
    listing_three = Fabricate(:listing, user: user, title: "Hipster Loft")

    Fabricate.times(3, :image, listing: listing_two)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within(".sidebar") do
      expect(page).to have_link("My Listings")
      click_on "My Listings"
    end

    expect(current_path).to eq(user_listings_path(user))

    within(".sidebar") do
      expect(page).to have_link("My Listings")
      expect(page).to have_link("Reservations")
      expect(page).to have_link("Messages")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Trips")
    end

    within(".my-listings") do
      expect(page).to have_link("Big House")
      expect(page).to have_link("Small Apartment")
      expect(page).to have_link("Hipster Loft")
    end

    click_on "Small Apartment"

    expect(current_path).to eq(user_listing_path(user, listing_two))

    within(".sidebar") do
      expect(page).to have_link("My Listings")
      expect(page).to have_link("Reservations")
      expect(page).to have_link("Messages")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Trips")
    end
  end
end
