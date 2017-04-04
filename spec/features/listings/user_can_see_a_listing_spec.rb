require 'rails_helper'

describe "user can see a listing" do
  scenario "when they visit the listing show page" do
    listing_1 = Fabricate(:listing)
    image_1, image_2, image_3 = Fabricate.times(3, :image, listing: listing_1)
    amenities = ["internet", "tv", "gym", "pool", "doorman"]

    amenities.each do |name|
      amenity = Amenity.create!(name: name)
      listing_1.listing_amenities.create!(amenity: amenity, value: true)
    end

    visit listings_path

    click_on "#{listing_1.title}"

    expect(current_path).to eq listing_path(listing_1)

    expect(page).to have_content(listing_1.title)
    expect(page).to have_content(listing_1.description)
    expect(page).to have_xpath("//img[@src='#{listing_1.images[0].image_url}']")
    expect(page).to have_xpath("//img[@src='#{listing_1.images[1].image_url}']")
    expect(page).to have_xpath("//img[@src='#{listing_1.images[2].image_url}']")

    within(".amenities") do
      expect(page).to have_content("Amenities at this property")
      expect(page).to have_content("Internet")
      expect(page).to have_content("Tv")
      expect(page).to have_content("Gym")
      expect(page).to have_content("Pool")
      expect(page).to have_content("Doorman")
    end
    end
end
