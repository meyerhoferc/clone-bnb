require 'rails_helper'

describe "from the host dashboard" do
  it "a host can update a reservation's status" do
    traveler = Fabricate(:user)
    traveler.roles.create!(title: "traveler")

    host = Fabricate(:user)
    host.roles.create!(title: "host")
    host.roles.create!(title: "traveler")
    listing = host.listings.create!(street_address: "1432 Axer Lane",
                                    city: "San Fran",
                                    state: "CA", zipcode: "45488",
                                    description: "Its cool",
                                    max_occupancy: 2,
                                    number_beds: 1,
                                    number_rooms: 1,
                                    number_baths: 1)

    res_one = listing.reservations.create!(start_date: "1/3/2012",
                                        end_date: "1/4/2012",
                                        user_id: traveler.id,
                                        status: "pending",
                                        listing_id: listing.id)

    res_two = listing.reservations.create!(start_date: "1/3/2012",
                                        end_date: "1/4/2012",
                                        user_id: traveler.id,
                                        status: "confirmed",
                                        listing_id: listing.id)

    res_three = listing.reservations.create!(start_date: "1/3/2012",
                                          end_date: "1/4/2012",
                                          user_id: traveler.id,
                                          status: "confirmed",
                                          listing_id: listing.id)

    res_four = listing.reservations.create!(start_date: "1/3/2012",
                                         end_date: "1/4/2012",
                                         user_id: traveler.id,
                                         status: "confirmed",
                                         listing_id: listing.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)

    visit dashboard_path
    click_on "Reservations"

    expect(current_path).to eq(user_reservations_path(host))

    within(".reservation-#{res_one.id}") do
      expect(page).to have_content("pending")
      click_on "Confirm"
      expect(page).to have_content("confirmed")
    end

    within(".reservation-#{res_two.id}") do
      expect(page).to have_content("pending")
      click_on "Cancel"
      expect(page).to have_content("cancelled")
    end

    within(".reservation-#{res_three.id}") do
      expect(page).to have_content("confirmed")
      click_on "Complete"
      expect(page).to have_content("completed")
    end
  end
end
