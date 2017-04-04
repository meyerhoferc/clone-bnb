require 'rails_helper'

describe "a user can view trip details" do
  it "as a logged in traveller" do
    user = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    user.roles.create!(title: "traveler")
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

    click_on "##{reservation.id}"
    expect(current_path).to eq(user_trip_path(user, reservation))

    within(".sidebar") do
      expect(page).to have_link("Messages")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Trips")
    end

    expect(page).to have_link("Super Cool Pad")
    expect(page).to have_content("1-1-2018")
    expect(page).to have_content("1-4-2018")
    within("#total") do
      expect(page).to have_content("Total Price: $90")
    end
    expect(page).to have_content("Status: pending")
    expect(page).to have_content("123 Street Denver")

    click_on "Super Cool Pad"

    expect(current_path).to eq(listing_path(listing))
  end

  it "as a logged in host" do
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

    click_on "##{reservation.id}"
    expect(current_path).to eq(user_trip_path(user, reservation))

    within(".sidebar") do
      expect(page).to have_link("Messages")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Trips")
      expect(page).to have_link("Reservations")
      expect(page).to have_link("My Listings")
    end

    expect(page).to have_link("Super Cool Pad")
    expect(page).to have_content("1-1-2018")
    expect(page).to have_content("1-4-2018")
    within("#total") do
      expect(page).to have_content("Total Price: $90")
    end
    expect(page).to have_content("Status: pending")
    expect(page).to have_content("123 Street Denver")

    click_on "Super Cool Pad"

    expect(current_path).to eq(listing_path(listing))
  end
end

describe "a logged in user" do
  it "cannot view trip details that are not theirs" do
    user = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    user.roles.create!(title: "traveler")

    other_user = User.create!(email: "other@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2341", password: "123")
    other_user.roles.create!(title: "traveler")
    listing = Fabricate(:listing,
                        title: "Super Cool Pad",
                        cost_per_night: 30,
                        street_address: "123 Street",
                        city: "Denver")
    Fabricate.times(3, :image, listing: listing)
    start_date = "01/01/2018"
    end_date = "04/01/2018"
    reservation = Reservation.create!(listing: listing,
                                      user: other_user,
                                      start_date: start_date,
                                      end_date: end_date)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within(".sidebar") do
      click_on "Trips"
    end

    within(".my-trips .records") do
      expect(page).to_not have_link("Super Cool Pad")
      expect(page).to_not have_content("1/1/2018")
      expect(page).to_not have_content("1/4/2018")
      expect(page).to_not have_content("$90")
      expect(page).to_not have_content("pending")
      expect(page).to_not have_content("123 Street Denver")
      expect(page).to_not have_link("##{reservation.id}")
    end

    visit user_trip_path(other_user, reservation)
    expect(page).to have_content("You don't have to go home, but you can't stay here! Error 404")

    expect(page).to_not have_link("Super Cool Pad")
    expect(page).to_not have_content("1-1-2018")
    expect(page).to_not have_content("1-4-2018")
    expect(page).to_not have_content("Total Price: $90")
    expect(page).to_not have_content("Status: pending")
    expect(page).to_not have_content("123 Street Denver")
  end
end
