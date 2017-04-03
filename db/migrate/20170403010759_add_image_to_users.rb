class AddImageToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :user_photo, :string
    add_attachment :users, :avatar
  end
end
