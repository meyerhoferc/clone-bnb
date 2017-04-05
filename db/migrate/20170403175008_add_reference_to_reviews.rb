class AddReferenceToReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :listing, foreign_key: true
  end
end
