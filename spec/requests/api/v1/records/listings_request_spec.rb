require 'rails_helper'

describe "Listings API" do
  it "can find by title" do
    title = Fabricate(:listing).title

    get "/api/v1/listings/find?title=#{title}"

    listing = JSON.parse(response.body)

    expect(response).to be_success
    expect(listing["title"]).to eq(title)
  end

  it "can find by street_address" do
    street_address = Fabricate(:listing).street_address

    get "/api/v1/listings/find?address=#{street_address}"

    listing = JSON.parse(response.body)

    expect(response).to be_success
    expect(listing["street_address"]).to eq(street_address)
  end
end
