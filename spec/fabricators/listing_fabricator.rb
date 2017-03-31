Fabricate.sequence(:street_address)
Fabricate.sequence(:description)
Fabricate.sequence(:city)
Fabricate.sequence(:state)
Fabricate.sequence(:zipcode)
Fabricate.sequence(:max_occupancy)
Fabricate.sequence(:title)
Fabricate.sequence(:list_category)
Fabricate.sequence(:number_beds)
Fabricate.sequence(:number_rooms)

Fabricator(:listing) do
  user {Fabricate(:user)}
  street_address {Faker::Address.street_address}
  city {Faker::Address.city}
  state {Faker::Address.state_abbr}
  zipcode {Faker::Address.zip}
  max_occupancy {Faker::Number.between(1, 30)}
  title {Faker::Hipster.sentence}
  list_category {["Entire home/apt", "Private room", "Shared room"].sample}
  number_beds {Faker::Number.between(1, 30)}
  number_rooms {Faker::Number.between(1, 30)}
  description "this is my decription"
  number_baths {Faker::Number.between(1, 10)}
end
