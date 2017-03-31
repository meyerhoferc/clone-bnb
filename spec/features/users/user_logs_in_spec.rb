require 'rails_helper'

describe "user logs in" do
  it "as a traveler" do
    pizza = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    pizza.roles.create(title: "traveler")
    visit root_path

    within(".navbar") do
      expect(page).to_not have_link("Become a Host")
    end

    click_on "Login"

    fill_in "session[email]", with: pizza.email
    fill_in "session[password]", with: pizza.password
    within(".login_btn") do
      click_on "Login"
    end

    within(".navbar") do
      expect(page).to have_link("Become a Host")
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(pizza.user_photo)
    expect(page).to have_content("Welcome, #{pizza.first_name} #{pizza.last_name}")
    expect(page).to have_content(pizza.about_me)
    expect(page).to have_content(pizza.email)
    expect(page).to have_content(pizza.phone_number)
    expect(page).to have_link("Profile")
    expect(page).to have_link("Messages")
    expect(page).to have_link("Trips")

    expect(page).to_not have_link("Reservations")
    expect(page).to_not have_link("Listings")
  end

  it "as a host" do
    cheese = User.create!(email: "cheese@email.com", first_name: "Velveeta", last_name: "Cheese", about_me: "yum yum yum", phone_number: "853-343-8439", password: "123")
    cheese.roles.create!(title: "host")
    cheese.roles.create!(title: "traveler")
    visit root_path
    click_on "Login"

    fill_in "session[email]", with: cheese.email
    fill_in "session[password]", with: cheese.password
    within(".login_btn") do
      click_on "Login"
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(cheese.user_photo)
    expect(page).to have_content("Welcome, #{cheese.first_name} #{cheese.last_name}")
    expect(page).to have_content(cheese.about_me)
    expect(page).to have_content(cheese.email)
    expect(page).to have_content(cheese.phone_number)
    expect(page).to have_link("Profile")
    expect(page).to have_link("Messages")
    expect(page).to have_link("Trips")

    expect(page).to have_link("Reservations")
    expect(page).to have_link("Listings")
  end

  it "doesn't input email correctly" do
    brownie = User.create(email: "brownie@email.com", first_name: "Brownie", last_name: "The Good Kind", about_me: "double fudge chocolate chip cookie", phone_number: "094-504-4542", password: "123")
    brownie.roles.create(title: "traveler")
    visit root_path
    click_on "Login"

    fill_in "session[email]", with: "Derp"
    fill_in "session[password]", with: brownie.password
    within(".login_btn") do
      click_on "Login"
    end

    expect(page).to have_content("Email or password has been entered incorrectly")
    expect(current_path).to eq(login_path)
  end

  it "doesn't input password correctly" do
    grape = User.create(email: "grape@email.com", first_name: "Grape", last_name: "Flavor", about_me: "I am a grape", phone_number: "045-345-3533", password: "123")
    grape.roles.create(title: "traveler")
    visit root_path
    click_on "Login"


    fill_in "session[email]", with: grape.email
    fill_in "session[password]", with: "NotDerp"
    within(".login_btn") do
      click_on "Login"
    end

    expect(page).to have_content("Email or password has been entered incorrectly")
    expect(current_path).to eq(login_path)
  end
end
