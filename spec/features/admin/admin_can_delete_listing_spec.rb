require 'rails_helper'

describe "as a logged in admin" do
  it "they can remove a listing from the admin listings index" do
    host = User.create(email: "host@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2349", password: "123")
    host.roles.create(title: "host")
    listing_one = Fabricate(:listing, user: host, title: "Big House")
    listing_two = Fabricate(:listing, user: host, title: "Small Apartment")
    listing_three = Fabricate(:listing, user: host, title: "Hipster Loft")
    Fabricate.times(3, :image, listing: listing_one)
    Fabricate.times(3, :image, listing: listing_two)
    Fabricate.times(3, :image, listing: listing_three)

    admin = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    admin.roles.create(title: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_listings_path
  end
end
