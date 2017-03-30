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

    expect(page).to have_link("Become a Host")
    expect(page).to have_link("Logout")
    expect(page).to_not have_link("Sign In")
    expect(page).to_not have_content("Sign Up")
  end
end
