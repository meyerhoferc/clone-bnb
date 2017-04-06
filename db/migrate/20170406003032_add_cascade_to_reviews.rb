class AddCascadeToReviews < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :reviews, :listings
    add_foreign_key :reviews, :listings, on_delete: :cascade
  end
end
