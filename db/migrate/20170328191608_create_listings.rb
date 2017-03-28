class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.references :user, foreign_key: true
      t.string :street_address
      t.string :description
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :max_occupancy
      t.string :title
      t.string :list_category
      t.string :number_beds
      t.string :number_rooms
    end
  end
end
