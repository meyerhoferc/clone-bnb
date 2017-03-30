require "rails_helper"

describe "user can edit profile" do
  it "from their dashboard" do
    traveler = Fabricate(:user)
    traveler.roles.create!(title: "traveler")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)
    visit dashboard_path

    click_on "Edit Profile"
    expect(current_path).to eq(user_edit_path)

    fill_in("user[first_name]", with: "Chealsea")
    fill_in("user[last_name]", with: "Lolittta")
    fill_in("user[about_me]", with: "Herm, derp, boop, bop")
    fill_in("user[email]", with: "supersecureemail@xyz.com")
    fill_in("user[phone_number]", with: "451-124-1555")
    fill_in("user[password]", with: "password")
    fill_in("user[password_confirmation]", with: "password")
    click_on "Update Account"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(traveler.first_name)  #if fails change to actual string
    expect(page).to have_content(traveler.last_name)
    expect(page).to have_content(traveler.about_me)
    expect(page).to have_content(traveler.email)
    expect(page).to have_content(traveler.phone_number)
  end
end
