class ChangeStringToCiText < ActiveRecord::Migration[5.0]
  def change
    enable_extension("citext")
    change_column :listings, :street_address, :citext
    change_column :listings, :city, :citext
    change_column :listings, :state, :citext
    change_column :listings, :title, :citext
  end
end
