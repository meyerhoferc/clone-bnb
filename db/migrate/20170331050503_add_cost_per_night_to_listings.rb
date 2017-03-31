class AddCostPerNightToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :cost_per_night, :integer
  end
end
