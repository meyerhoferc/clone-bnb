require 'rails_helper'

describe "user can see a listing" do
  scenario "when they visit the listing show page" do
    listing_1 = Fabricate(:listing)
    image_1, image_2, image_3 = Fabricate.times(3, :image, listing: listing_1)

    visit listings_path

    click_on "#{listing_1.title}"

    expect(current_path).to eq listing_path(listing_1)

    expect(page).to have_content(listing_1.title)
    expect(page).to have_content(listing_1.description)
    expect(page).to have_xpath("//img[@src='#{listing_1.images[0].image_url}']")
    expect(page).to have_xpath("//img[@src='#{listing_1.images[1].image_url}']")
    expect(page).to have_xpath("//img[@src='#{listing_1.images[2].image_url}']")
    expect(page).to have_xpath("//img[@src='#{listing_1.user.user_photo}']")
    #add expect amenities when we build this functionality
    end
end
