class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :about_me
      t.string :user_photo
      t.string :phone_number
    end
  end
end
