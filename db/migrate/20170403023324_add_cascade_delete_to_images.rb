class AddCascadeDeleteToImages < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :images, :listings
    add_foreign_key :images, :listings, on_delete: :cascade

  end
end
