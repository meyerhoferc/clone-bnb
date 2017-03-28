class AddListingsToUserRoles < ActiveRecord::Migration[5.0]
  def change
    add_reference :user_roles, :listing, foreign_key: true
  end
end
