class AddCascadeToListingAmennities < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :listing_amenities, :listings
    add_foreign_key :listing_amenities, :listings, on_delete: :cascade
  end
end
