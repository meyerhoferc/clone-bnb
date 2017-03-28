require 'rails_helper'

describe "creating an account" do
  it "a user can create a traveler account" do
    expect(User.count).to eq(0)
    visit root_path
    click_on "Sign Up"
    expect(current_path).to eq(new_user_path)

    fill_in("user[first_name]", with: "First")
    fill_in("user[last_name]", with: "Last")
    fill_in("user[email]", with: "email@email.com")
    fill_in("user[password]", with: "password")
    fill_in("user[password_confirmation]", with: "password")
    click_on "Create Account"

    expect(User.count).to eq(1)
    expect(current_path).to eq(dashboard_path)

    within(".success") do
      expect(page).to have_content("Successfully logged in as First Last")
    end

    within("h1") do
      expect(page).to have_content("Welcome, First Last")
    end

    within(".my-profile") do
      expect(page).to have_content("Email: email@email.com")
    end
  end
end
