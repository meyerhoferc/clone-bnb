require 'rails_helper'

describe "user tries to log in" do
  it "they have forgotten password" do
    user = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    user.roles.create(title: "traveler")
    code = "1234"

    allow_any_instance_of(TwilioService).to receive(:send_password_code).and_return(code)

    visit login_path

    click_on "Forgot Password?"

    expect(current_path).to eq(code_path)

    fill_in("phone_number", with: "853-343-2343")

    click_on "Send Message"

    expect(current_path).to eq(verify_code_path)

    fill_in("code", with: code)

    click_on "Verify"

    expect(current_path).to eq(reset_password_path)

    fill_in("user[password]", with: "password")
    fill_in("user[password_confirmation]", with: "password")

    click_on "Reset Password"

    within(".success") do
      expect(page).to have_content("Password successfully changed")
    end

    expect(current_path).to eq(login_path)

    fill_in("session[email]", with: "email@email.com")
    fill_in("session[password]", with: "password")

    click_on "Login"

    within(".success") do
      expect(page).to have_content("Logged in as Castle Pines")
    end
    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Welcome, Castle Pines")
  end
end
