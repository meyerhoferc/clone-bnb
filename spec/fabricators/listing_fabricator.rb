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
  street_address { sequence(:street_address) { |i| "street_address#{i}"} }
  description { sequence(:description) { |i| "description#{i}"} }
  city { sequence(:city) { |i| "city#{i}"} }
  state { sequence(:state) { |i| "state#{i}"} }
  zipcode { sequence(:zipcode) { |i| "zipcode#{i}"} }
  max_occupancy { sequence(:max_occupancy) { |i| "max_occupancy#{i}"} }
  title { sequence(:title) { |i| "title#{i}"} }
  list_category { sequence(:list_category) { |i| "list_category#{i}"} }
  number_beds { sequence(:number_beds) { |i| "number_beds#{i}"} }
  number_rooms { sequence(:number_rooms) { |i| "number_rooms#{i}"} }
end
