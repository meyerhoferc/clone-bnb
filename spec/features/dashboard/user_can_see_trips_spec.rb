require 'rails_helper'

describe "a user can see trips" do
  it "with a role of traveler" do
    user = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    user.roles.create!(title: "host")
    listing = Fabricate(:listing,
                        title: "Super Cool Pad",
                        cost_per_night: 30,
                        street_address: "123 Street",
                        city: "Denver")
    Fabricate.times(3, :image, listing: listing)
    start_date = "01/01/2018"
    end_date = "04/01/2018"
    reservation = Reservation.create!(listing: listing,
                                      user: user,
                                      start_date: start_date,
                                      end_date: end_date)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within(".sidebar") do
      click_on "Trips"
    end

    expect(current_path).to eq(user_trips_path(user))

    within(".my-trips .headers") do
      expect(page).to have_content("Check-In")
      expect(page).to have_content("Check-Out")
      expect(page).to have_content("Price")
      expect(page).to have_content("Status")
      expect(page).to have_content("Property")
      expect(page).to have_content("Address")
      expect(page).to have_content("Trip")
    end

    within(".my-trips .records") do
      expect(page).to have_link("Super Cool Pad")
      expect(page).to have_content("1/1/2018")
      expect(page).to have_content("1/4/2018")
      expect(page).to have_content("$90")
      expect(page).to have_content("pending")
      expect(page).to have_content("123 Street Denver")
      expect(page).to have_link("##{reservation.id}")
    end

    click_on "Super Cool Pad"

    expect(current_path).to eq(listing_path(listing))
  end

  it "with the role of a host" do

  end
end
