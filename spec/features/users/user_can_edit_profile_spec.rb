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

  it "cannot edit the profile of another user" do
    user = User.create(email: "email@email.com", first_name: "User", last_name: "Name", about_me: "Logged in", phone_number: "853-343-2343", password: "123")
    user.roles.create(title: "traveler")
    host = User.create(email: "host@email.com", first_name: "Castle", last_name: "Pines", about_me: "Not", phone_number: "853-343-9943", password: "123")
    host.roles.create(title: "host")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/users/#{host.id}/edit"

    expect(page).to_not have_content("host@email.com")
    expect(page).to_not have_content("Castle")
    expect(page).to_not have_content("Pines")
    expect(page).to_not have_content("Not")
  end
end
