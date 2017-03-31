class AddCostPerNightToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :cost_per_night, :integer, default: 0
  end
end
