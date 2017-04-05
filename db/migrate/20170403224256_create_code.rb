class CreateCode < ActiveRecord::Migration[5.0]
  def change
    create_table :codes do |t|
      t.references :user, foreign_key: true
      t.string :phone_number
      t.string :body
    end
  end
end
