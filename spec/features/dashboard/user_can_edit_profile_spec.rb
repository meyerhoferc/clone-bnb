require "rails_helper"

describe "user can edit profile" do
  it "from their dashboard" do
    traveler = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    traveler.roles.create!(title: "traveler")

    visit login_path
    fill_in("session[email]", with: traveler.email)
    fill_in("session[password]", with: traveler.password)
    within(".login_btn") do
      click_on "Login"
    end
    click_on "Edit Profile"
    expect(current_path).to eq(edit_user_path(traveler))
    fill_in("user[first_name]", with: "Chealsea")
    fill_in("user[last_name]", with: "Lolittta")
    fill_in("user[about_me]", with: "Herm, derp, boop, bop")
    fill_in("user[email]", with: "supersecureemail@xyz.com")
    fill_in("user[phone_number]", with: "451-124-1555")
    click_on "Update Account"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Chealsea")
    expect(page).to have_content("Lolittta")
    expect(page).to have_content("Herm, derp, boop, bop")
    expect(page).to have_content("supersecureemail@xyz.com")
    expect(page).to have_content("451-124-1555")
  end
  it "but not other users' profiles" do
    traveler_1 = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    traveler_1.roles.create!(title: "traveler")
    traveler_2 = User.create!(email: "next@email.com", first_name: "The", last_name: "Carlton", about_me: "I jiggy wit it", phone_number: "853-343-2344", password: "123")
    traveler_2.roles.create!(title: "traveler")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler_1)

    visit "/users/#{traveler_2.id}/edit"

    expect(page).to_not have_content("The")
    expect(page).to_not have_content("Carlton")
    expect(page).to_not have_content("I jiggy wit it")
  end
end
