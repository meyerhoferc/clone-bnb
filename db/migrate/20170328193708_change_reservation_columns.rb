class ChangeReservationColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :reservations, :host_id
    remove_column :reservations, :traveler_id
    add_reference :reservations, :user, foreign_key: true
  end
end
