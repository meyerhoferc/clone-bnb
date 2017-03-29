class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.integer :host_id
      t.integer :traveler_id
      t.date :start_date
      t.date :end_date
      t.references :listing, foreign_key: true
      t.integer :status
    end
  end
end
