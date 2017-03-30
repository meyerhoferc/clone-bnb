require "rails_helper"

describe "user profile" do
  it "traveler profile on user dashboard" do
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

  it "host profile on user dashboard" do
    host = Fabricate(:user)
    host.roles.create!(title: "host")
    #allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)
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
end
