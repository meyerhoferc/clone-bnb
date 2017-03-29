require 'rails_helper'

describe "user authorization" do
  it "a guest cannot view a user's information" do
    user = Fabricate(:user)
    visit dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist (404)")

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
end
