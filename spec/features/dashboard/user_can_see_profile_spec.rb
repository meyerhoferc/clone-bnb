require "rails_helper"

describe "user profile" do
  it "for traveler on user dashboard" do
    traveler = Fabricate(:user)
    traveler.roles.create!(title: "traveler")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)
    visit dashboard_path

    expect(page).to have_content("Profile")
    expect(page).to have_content("Welcome, #{traveler.first_name} #{traveler.last_name}")
    expect(page).to have_content(traveler.about_me)
    expect(page).to have_content(traveler.email)
    expect(page).to have_content(traveler.phone_number)
    expect(page).to have_link("Edit Profile")

    expect(page).to have_link("Profile")
    expect(page).to have_link("Messages")
    expect(page).to have_link("Trips")
    expect(page).to_not have_link("Reservations")
    expect(page).to_not have_link("Listings")

    expect(page).to have_link("Become a Host")
    expect(page).to have_link("Logout")
    expect(page).to_not have_link("Sign In")
    expect(page).to_not have_content("Sign Up")
  end

  it "for host on user dashboard" do
    host = Fabricate(:user)
    host.roles.create!(title: "host")
    host.roles.create!(title: "traveler")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)
    visit dashboard_path

    expect(page).to have_content("Profile")
    expect(page).to have_content("Welcome, #{host.first_name} #{host.last_name}")
    expect(page).to have_content(host.about_me)
    expect(page).to have_content(host.email)
    expect(page).to have_content(host.phone_number)
    expect(page).to have_link("Edit Profile")

    expect(page).to have_link("Profile")
    expect(page).to have_link("Messages")
    expect(page).to have_link("Trips")
    expect(page).to have_link("Reservations")
    expect(page).to have_link("Listings")

    expect(page).to_not have_link("Become a Host")
    expect(page).to have_link("Logout")
    expect(page).to_not have_link("Sign In")
    expect(page).to_not have_content("Sign Up")
  end

  it "has a complete sidebar" do
    host = Fabricate(:user)
    host.roles.create!(title: "host")
    host.roles.create!(title: "traveler")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)
    visit dashboard_path

    click_on "Dashboard"
    expect(current_path).to eq(dashboard_path)

    click_on "Messages"
    expect(current_path).to eq(user_messages_path(host))
    expect(page).to have_content("Messages")

    visit dashboard_path
    click_on "Trips"
    expect(current_path).to eq(user_trips_path(host))
    expect(page).to have_content("Trips")

    visit dashboard_path
    click_on "Reservations"
    expect(current_path).to eq(user_reservations_path(host))
    expect(page).to have_content("Reservations")
  end
end
