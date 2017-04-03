require 'rails_helper'

describe "a logged in user" do
  it "can edit their profile" do
    user = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    user.roles.create(title: "traveler")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    click_on "Edit Profile"

    expect(current_path).to eq(edit_user_path(user))

    fill_in("user[email]", with: "new@com.com")
    click_on "Update Account"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("new@com.com")
    expect(page).to_not have_content("email@email.com")
  end
end
