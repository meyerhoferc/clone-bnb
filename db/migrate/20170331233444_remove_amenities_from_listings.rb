class RemoveAmenitiesFromListings < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :number_baths, :boolean
    add_column :listings, :number_baths, :integer
    remove_column :listings, :elevator, :boolean
    remove_column :listings, :pets_allowed, :boolean
    remove_column :listings, :free_parking, :boolean
    remove_column :listings, :family_kid_friendly, :boolean
    remove_column :listings, :doorman, :boolean
    remove_column :listings, :pool, :boolean
    remove_column :listings, :hot_tub, :boolean
    remove_column :listings, :gym, :boolean
    remove_column :listings, :air_conditioning, :boolean
    remove_column :listings, :wheelchair_accessible, :boolean
    remove_column :listings, :internet, :boolean
    remove_column :listings, :smoking_allowed, :boolean
    remove_column :listings, :suitable_for_events, :boolean
    remove_column :listings, :wireless_internet, :boolean
    remove_column :listings, :indoor_fireplace, :boolean
    remove_column :listings, :breakfast, :boolean
    remove_column :listings, :kitchen, :boolean
    remove_column :listings, :cable_tv, :boolean
    remove_column :listings, :dryer, :boolean
    remove_column :listings, :hair_dryer, :boolean
    remove_column :listings, :washer, :boolean
    remove_column :listings, :tv, :boolean
    remove_column :listings, :buzzer_wireless_intercom, :boolean
    remove_column :listings, :iron, :boolean
    remove_column :listings, :essentials, :boolean
    remove_column :listings, :laptop_friendly_workspace, :boolean
    remove_column :listings, :heating, :boolean
    remove_column :listings, :private_entrance, :boolean
  end
end
