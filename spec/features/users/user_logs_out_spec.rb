require 'rails_helper'

describe "a logged in user" do
  it "can log out" do
    user = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")

    visit login_path

    within(".navbar") do
      expect(page).to have_link("Login")
      expect(page).to_not have_link("Logout")
    end

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password

    within(".login_btn") do
      click_on "Login"
    end

    within(".navbar") do
      expect(page).to have_link("Logout")
      expect(page).to_not have_link("Login")
    end

    click_on "Logout"

    expect(current_path).to eq(root_path)

    within(".success") do
      expect(page).to have_content("Logged out successfully")
    end

    within(".navbar") do
      expect(page).to have_link("Login")
      expect(page).to_not have_link("Logout")
    end
  end
end
