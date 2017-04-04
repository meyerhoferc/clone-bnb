require "rails_helper"

describe "traveler can make a review" do
  it "for each listing a traveler has stayed at" do
    traveler = User.create!(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    traveler.roles.create!(title: "traveler")
    host = User.create!(email: "derpl@email.com", first_name: "Monster", last_name: "Can", about_me: "Boop beep boop", phone_number: "853-343-3453", password: "123")
    host.roles.create!(title: "traveler")
    host.roles.create!(title: "host")
    a_listing = host.listings.create!(street_address: "1212 Derp Lane", description: "derp", city: "Denver", state: "CO", zipcode: "35343", max_occupancy: "2", title: "cool", list_category: "house", number_beds: "1", number_rooms: "1", cost_per_night: 234, number_baths: 1)
    image_1, image_2, image_3 = Fabricate.times(3, :image, listing: a_listing)

    one = traveler.reservations.create!(start_date: "4/1/17", end_date: "4/2/17", listing_id: a_listing.id, status: "complete")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(traveler)


    visit dashboard_path
    click_on "Reviews"
    #save_and_open_page

    expect(page).to have_content(a_listing.street_address)

    within(".listing_#{a_listing.id}") do
      click_on "View Listing"
    end

    expect(current_path).to eq(listing_path(a_listing))
    expect(page).to have_link "Write a Review"  #

    click_on "Write a Review"

    expect(current_path).to eq(listing_reviews_new_path(a_listing))

    fill_in("review[title]", with: "This was great")
    fill_in("review[stars]", with: 5)
    fill_in("review[message]", with: "The house was beautiful, clean, and they had extra towels and bathroom amenities")
    click_on "Add Review"

    expect(current_path).to eq(listing_path(a_listing))
    expect(page).to have_content("This was great")
    expect(page).to have_content(5)
    expect(page).to have_content("The house was beautiful, clean, and they had extra towels and bathroom amenities")
  end
end
