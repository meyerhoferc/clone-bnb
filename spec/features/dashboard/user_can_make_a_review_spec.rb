require "rails_helper"

describe "user can make a review" do
  it "for each listing a traveler has stayed at" do
    traveler = Fabricator(:user)
    listing = Fabricator(:listing)
    one = user.reservations.create!(start_date: "4/1/17", end_date: "4/3/17", listing_id: listing.id, status: "complete")
    two = user.reservations.create!(start_date: "4/1/17", end_date: "4/3/17", listing_id: listing.id, status: "complete")
    three = user.reservations.create!(start_date: "4/1/17", end_date: "4/3/17", listing_id: listing.id, status: "complete")
    four = user.reservations.create!(start_date: "4/1/17", end_date: "4/3/17", listing_id: listing.id, status: "complete")
    completed_trips = [one, two, three, four]

    visit dashboard_path
    click_on "Reviews"


    expect(page).to have_content(completed_trips)

    within(".listing_#{one.id}") do
      click_on "Write a Review"
    end

    expect(current_path).to eq(listing_reviews_path(listing))

    fill_in("review[:title]", with: "This was great")
    fill_in("review[:stars]", with: 5)
    fill_in("review[:message]", with: "The house was beautiful, clean, and they had extra towels and bathroom amenities")
    click_on "Add Review"
      end

      expect(current_path).to eq("listings/#{listing.id}")
      expect(page).to have_content("This was great")
      expect(page).to have_content(5)
      expect(page).to have_content("The house was beautiful, clean, and they had extra towels and bathroom amenities")
    end
  end
end
