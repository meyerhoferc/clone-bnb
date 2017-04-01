class RemoveListingFromUserRole < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_roles, :listing_id, :integer
  end
end
