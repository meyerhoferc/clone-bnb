require 'rails_helper'

describe "registered traveller can be come a host" do
  it "by clicking a link in the navbar" do
    user = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    user.roles.create!(title: "traveler")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    expect(user.host?).to eq(false)

    within(".navbar") do
      click_on "Become a Host"
    end

    expect(current_path).to eq(edit_user_path(user))

    within(".add-host-permissions") do
      click_on "Become a Host"
    end

    expect(current_path).to eq(dashboard_path)

    within(".success") do
      expect(page).to have_content("Account successfully updated")
    end

    within(".navbar") do
      expect(page).to_not have_link("Become a Host")
    end

    expect(user.host?).to eq(true)
  end
end
