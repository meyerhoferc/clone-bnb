require 'rails_helper'

describe "a logged in user" do
  it "can create a reservation for a listing" do
    user = User.create!(email: "email@email.com",
                        first_name: "Castle",
                        last_name: "Pines",
                        about_me: "Boop beep boop",
                        phone_number: "853-343-2343",
                        password: "123")
    user.roles.create!(title: "traveler")
    listing = Fabricate(:listing)
    image = Fabricate.times(3, :image, listing: listing)
    host = listing.user

    visit listing_path(listing)
    click_on "Book Now"

    expect(current_path).to eq(new_reservation_path)

  end
end
