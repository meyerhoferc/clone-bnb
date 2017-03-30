class AddDefaultToReservationStatus < ActiveRecord::Migration[5.0]
  def change
    remove_column :reservations, :status, :integer
    add_column :reservations, :status, :integer, default: 0
  end
end
