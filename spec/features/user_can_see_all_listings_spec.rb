require 'rails_helper'

describe "user can see all listings available" do
  scenario "when they visit the listings index page" do
    listing_1, listing_2 = Fabricate.times(2, :listing)

    visit listings_path

    expect(page).to have_content(listing_1.street_address)

  end
end
