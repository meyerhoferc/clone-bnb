class Seed

  def self.start
    seed = Seed.new
    seed.generate_users
    seed.generate_listings
    seed.generate_images
    seed.generate_reservations
    seed.generate_roles
  end

  def generate_users
    1000.times do |i|
      user = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.unique.free_email,
        about_me: Faker::Hipster.paragraph,
        user_photo: "http://robohash.org/#{i}.png",
        phone_number: Faker::PhoneNumber.unique.cell_phone,
        password: "password"
      )
      puts "User #{user.last_name}, #{user.first_name} created!"
    end
  end

  def generate_listings
    1000.times do |i|
      user = User.find(Random.new.rand(1..1000))
      listing = Listing.create!(
        user_id: user.id,
        title: Faker::Company.catch_phrase,
        street_address: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zipcode: Faker::Address.zip,
        max_occupancy: Faker::Number.between(1, 30),
        description: Faker::Hipster.paragraph,
        list_category: ["Entire home/apt", "Private room", "Shared room"].sample,
        number_beds:Faker::Number.between(1, 30),
        number_rooms: Faker::Number.between(1, 30),
        number_baths: Faker::Number.between(1, 5),
        cost_per_night: Faker::Number.between(1, 350),
        elevator: [true, false].sample,
        pets_allowed: [true, false].sample,
        free_parking: [true, false].sample,
        family_kid_friendly: [true, false].sample,
        doorman:[true, false].sample,
        pool: [true, false].sample,
        hot_tub: [true, false].sample,
        gym: [true, false].sample,
        air_conditioning: [true, false].sample,
        wheelchair_accessible: [true, false].sample,
        internet: [true, false].sample,
        smoking_allowed: [true, false].sample,
        suitable_for_events: [true, false].sample,
        wireless_internet: [true, false].sample,
        indoor_fireplace: [true, false].sample,
        breakfast: [true, false].sample,
        kitchen: [true, false].sample,
        cable_tv: [true, false].sample,
        dryer: [true, false].sample,
        hair_dryer: [true, false].sample,
        washer: [true, false].sample,
        tv: [true, false].sample,
        buzzer_wireless_intercom: [true, false].sample,
        iron: [true, false].sample,
        essentials: [true, false].sample,
        laptop_friendly_workspace: [true, false].sample,
        heating: [true, false].sample,
        private_entrance: [true, false].sample
        )
        puts "Listing #{listing.title} created!"
    end
  end

  def generate_images
    listing = Listing.all.each do |listing|
      3.times do
        image = Image.create!(
          image_url: Faker::LoremPixel.image("700x400", false, 'city'),
          listing_id: listing.id
          )
          puts "Image for #{image.listing_id} created!"
      end
    end
  end

  def generate_reservations
    3000.times do |i|
      listing = Listing.find(Random.new.rand(1..1000))
      user = User.find(Random.new.rand(1..1000))
      start_date = Faker::Date.between(Date.today, 1.year.from_now)
      end_date = Faker::Date.between(start_date, 1.year.from_now)
      reservation = Reservation.create!(
        start_date: start_date,
        end_date: end_date,
        listing_id: listing.id,
        status: ["confirmed", "pending", "cancelled", "complete"].sample,
        user_id: user.id
      )
      puts "Reservation #{reservation.id} created!"
    end
  end

  def generate_roles
    Role.create!(title: "admin")
    puts "Admin role created!"
    Role.create!(title: "host")
    puts "Host role created!"
    Role.create!(title: "traveler")
    puts "Traveler role created!"
  end
end

Seed.start
