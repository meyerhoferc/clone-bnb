class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :host_id
      t.integer :traveler_id
      t.string :body
    end
  end
end
