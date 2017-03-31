require "rails_helper"

describe "host can view reservations" do
  it "sees all reservations past, present, future" do
    traveler = Fabricate(:user)
    traveler.roles.create!(title: "traveler")

    host = Fabricate(:user)
    host.roles.create!(title: "host")
    host.roles.create!(title: "traveler")
    listing = host.listings.create!(street_address: "1432 Axer Lane",
                                    city: "San Fran",
                                    state: "CA", zipcode: "45488")

    res_one = host.reservations.create!(start_date: "1/3/2012",
                                        end_date: "1/4/2012",
                                        user_id: traveler.id,
                                        status: "pending",
                                        listing_id: listing.id)

    res_two = host.reservations.create!(start_date: "1/3/2012",
                                        end_date: "1/4/2012",
                                        user_id: traveler.id,
                                        status: "pending",
                                        listing_id: listing.id)

    res_three = host.reservations.create!(start_date: "1/3/2012",
                                          end_date: "1/4/2012",
                                          user_id: traveler.id,
                                          status: "confirmed",
                                          listing_id: listing.id)

    res_four = host.reservations.create!(start_date: "1/3/2012",
                                         end_date: "1/4/2012",
                                         user_id: traveler.id,
                                         status: "confirmed",
                                         listing_id: listing.id)

    res_five = host.reservations.create!(start_date: "1/3/2012",
                                         end_date: "1/4/2012",
                                         user_id: traveler.id,
                                         status: "cancelled",
                                         listing_id: listing.id)

    res_six = host.reservations.create!(start_date: "1/3/2012",
                                        end_date: "1/4/2012",
                                        user_id: traveler.id,
                                        status: "cancelled",
                                        listing_id: listing.id)

    res_seven = host.reservations.create!(start_date: "1/3/2012",
                                          end_date: "1/4/2012",
                                          user_id: traveler.id,
                                          status: "completed",
                                          listing_id: listing.id)

    res_eight = host.reservations.create!(start_date: "1/3/2012",
                                          end_date: "1/4/2012",
                                          user_id: traveler.id,
                                          status: "completed",
                                          listing_id: listing.id)


    allow_any_instance_of(ApplicationController).receive(:current_user).and_return(host)
    visit dashboard_path
    click_on "Reservations"

    expect(page).to have_content("Reservations")
    within(".pending") do
      expect(page).to have_content(res_one)
      expect(page).to have_content(res_two)
    end

    within(".confirmed") do
      expect(page).to have_content(res_one)
      expect(page).to have_content(res_two)
    end

    within(".cancelled") do
      expect(page).to have_content(res_one)
      expect(page).to have_content(res_two)
    end

    within(".completed") do
      expect(page).to have_content(res_one)
      expect(page).to have_content(res_two)
    end
  end
end
