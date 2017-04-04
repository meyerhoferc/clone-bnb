require 'rails_helper'

describe "user authorization" do
  it "a guest cannot view a user's information" do
    user = Fabricate(:user)
    visit dashboard_path

    expect(page).to have_content("You don't have to go home, but you can't stay here! Error 404")

    expect(page).to_not have_content(user.first_name)
    expect(page).to_not have_content(user.last_name)
    expect(page).to_not have_content(user.about_me)
    expect(page).to_not have_content(user.email)
    expect(page).to_not have_content(user.phone_number)
  end

  it "a user cannot view another user's information" do
    user_one, user_two = Fabricate.times(2, :user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_one)
    visit dashboard_path

    expect(page).to_not have_content(user_two.first_name)
    expect(page).to_not have_content(user_two.last_name)
    expect(page).to_not have_content(user_two.about_me)
    expect(page).to_not have_content(user_two.email)
    expect(page).to_not have_content(user_two.phone_number)
  end

  it "user dashboard be viewed by an admin" do
    admin = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    admin.roles.create(title: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit dashboard_path
    expect(page).to have_content("You don't have to go home, but you can't stay here! Error 404")
  end
end
