require 'rails_helper'

describe "user can see all listings available" do
  scenario "when they visit the listings index page" do

    visit listings_path

    expect(page).to have_content

  end
end
