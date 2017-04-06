class AddCascadeDeleteToReservations < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :reservations, :listings
    add_foreign_key :reservations, :listings, on_delete: :cascade
  end
end
