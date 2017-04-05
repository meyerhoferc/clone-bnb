describe "as a logged in admin" do
  it "they can remove a user's content" do
    host = User.create(email: "host@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2349", password: "123")
    host.roles.create(title: "host")
    listing_one = Fabricate(:listing, user: host, title: "Big House")
    listing_two = Fabricate(:listing, user: host, title: "Small Apartment")
    listing_three = Fabricate(:listing, user: host, title: "Hipster Loft")
    Fabricate.times(3, :image, listing: listing_one)
    Fabricate.times(3, :image, listing: listing_two)
    Fabricate.times(3, :image, listing: listing_three)

    visit listings_path

    expect(page).to have_link("Big House")
    expect(page).to have_link("Small Apartment")
    expect(page).to have_link("Hipster Loft")

    admin = User.create(email: "email@email.com", first_name: "Castle", last_name: "Pines", about_me: "Boop beep boop", phone_number: "853-343-2343", password: "123")
    admin.roles.create(title: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    within(".sidebar") do
      click_on "Users"
    end

    expect(page).to have_content("active")
    expect(current_path).to eq(admin_users_path)

    click_on "Deactivate User"

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content("inactive")

    visit listings_path

    expect(page).to_not have_link("Big House")
    expect(page).to_not have_link("Small Apartment")
    expect(page).to_not have_link("Hipster Loft")

    visit listing_path(listing_one)

    expect(page).to have_content("You don't have to go home, but you can't stay here! Error 404")

    expect(host.listings.count).to eq(3)
    expect(host.listings.first.title).to eq("Big House")
  end
end
