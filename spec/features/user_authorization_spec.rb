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

end
