require 'rails_helper'

describe "user logs in" do
  it "as a traveler" do
    pizza = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    pizza.roles.new(title: "traveler")
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
  end

  it "as a host" do
    cheese = User.create(email: "cheese@email.com", first_name: "Velveeta", last_name: "Cheese", about_me: "yum yum yum", phone_number: "853-343-8439", password: "123")
    cheese.roles.new(title: "host")
    visit root_path
    click_on "Login"

    fill_in "session[email]", with: cheese.email
    fill_in "session[password]", with: cheese.password
    within(".login_btn") do
      click_on "Login"
    end

    expect(current_path).to eq(dashboard_path)
    # test to see that host user sees correct things on dashboard
  end

  it "doesn't input email correctly" do
    brownie = User.create(email: "brownie@email.com", first_name: "Brownie", last_name: "The Good Kind", about_me: "double fudge chocolate chip cookie", phone_number: "094-504-4542", password: "123")
    brownie.roles.new(title: "travelers")
    visit root_path
    click_on "Login"

    fill_in "session[email]", with: "Derp"
    fill_in "session[password]", with: brownie.password
    within(".login_btn") do
      click_on "Login"
    end

    expect(page).to have_content("Email or password has been entered incorrectly")
  end

  it "doesn't input password correctly" do
    grape = User.create(email: "grape@email.com", first_name: "Grape", last_name: "Flavor", about_me: "I am a grape", phone_number: "045-345-3533", password: "123")
    grape.roles.new(title: "travelers")
    visit root_path
    click_on "Login"


    fill_in "session[email]", with: grape.email
    fill_in "session[password]", with: "NotDerp"
    within(".login_btn") do
      click_on "Login"
    end

    expect(page).to have_content("Email or password has been entered incorrectly")
  end
end
