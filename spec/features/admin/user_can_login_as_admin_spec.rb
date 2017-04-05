require 'rails_helper'

describe "admin dashboard" do
  it "can be accessed by a logged in admin" do
    admin = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    admin.roles.create(title: "admin")

    visit root_path

    click_on "Login"

    fill_in("session[email]", with: admin.email)
    fill_in("session[password]", with: admin.password)

    within(".login_btn") do
      click_on "Login"
    end

    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_content("Welcome, Castle Pines")

    expect(page).to have_content("Email: email@email.com")
    expect(page).to have_content("853-343-2343")

    within(".sidebar") do
      expect(page).to have_link("Users")
      expect(page).to have_link("Listings")
      expect(page).to have_link("Reviews")
    end
  end

  it "cannot be accessed by a non-admin user" do
    user = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    user.roles.create(title: "user")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path

    expect(page).to have_content("You don't have to go home, but you can't stay here! Error 404")

    expect(page).to_not have_link("Users")
  end

  it "cannot be accessed by a non-logged in user" do
    visit admin_dashboard_path
    expect(page).to have_content("You don't have to go home, but you can't stay here! Error 404")
    expect(page).to_not have_link("Users")
  end
end
