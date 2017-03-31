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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    listing = Fabricate(:listing)
    image = Fabricate.times(3, :image, listing: listing)
    host = listing.user

    expect(Reservation.count).to eq(0)

    visit listing_path(listing)
    click_on "Book Now"
    expect(current_path).to eq(new_listing_reservation_path(listing))
    fill_in("reservation[start_date]", with: "01/01/2018")
    fill_in("reservation[end_date]", with: "03/01/2018")

    click_on "Confirm Reservation"

    expect(Reservation.count).to eq(1)
    reservation = Reservation.last

    expect(current_path).to eq(reservation_path(reservation))

    within(".success") do
      expect(page).to have_content("Successfully made reservation")
    end
    within(".dates") do
      expect(page).to have_content("#{reservation.start_date}")
    end
    within(".dates") do
      expect(page).to have_content("#{reservation.end_date}")
    end
    within(".charges") do
      expect(page).to have_content("$#{reservation.unit_cost} x #{reservation.num_nights}")
    end

    expect(reservation.status).to eq("pending")
    expect(reservation.user).to eq(user)
    expect(reservation.listing).to eq(listing)

    start_date, middle_date, end_date = ["01/01/2018", "02/01/2018", "03/01/2018"]
    expect(listing.range_available?(start_date, end_date)).to eq(false)
    expect(listing.date_available?(middle_date)).to eq(false)
  end

  it "cannot make a reservation for a listing that is booked on that date" do


    user = User.create!(email: "email@email.com",
                        first_name: "Castle",
                        last_name: "Pines",
                        about_me: "Boop beep boop",
                        phone_number: "853-343-2343",
                        password: "123")
    user.roles.create!(title: "traveler")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    listing = Fabricate(:listing)
    image = Fabricate.times(3, :image, listing: listing)

    start_date = "01/01/2018"
    end_date = "04/01/2018"
    Reservation.create!(listing: listing,
                        user: user,
                        start_date: start_date,
                        end_date: end_date)

    expect(Reservation.count).to eq(1)

    visit listing_path(listing)
    click_on "Book Now"
    expect(current_path).to eq(new_listing_reservation_path(listing))

    fill_in("reservation[start_date]", with: "01/01/2018")
    fill_in("reservation[end_date]", with: "03/01/2018")

    click_on "Confirm Reservation"

    expect(Reservation.count).to eq(1)

    expect(page).to_not have_content("Check-in")
    expect(page).to_not have_content("Check-out")
    expect(page).to_not have_content("Reservation ID:")
  end
end
