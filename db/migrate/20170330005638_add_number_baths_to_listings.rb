class AddNumberBathsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :number_baths, :boolean, default: false
    add_column :listings, :elevator, :boolean, default: false
    add_column :listings, :pets_allowed, :boolean, default: false
    add_column :listings, :free_parking, :boolean, default: false
    add_column :listings, :family_kid_friendly, :boolean, default: false
    add_column :listings, :doorman, :boolean, default: false
    add_column :listings, :pool, :boolean, default: false
    add_column :listings, :hot_tub, :boolean, default: false
    add_column :listings, :gym, :boolean, default: false
    add_column :listings, :air_conditioning, :boolean, default: false
    add_column :listings, :wheelchair_accessible, :boolean, default: false
    add_column :listings, :internet, :boolean, default: false
    add_column :listings, :smoking_allowed, :boolean, default: false
    add_column :listings, :suitable_for_events, :boolean, default: false
    add_column :listings, :wireless_internet, :boolean, default: false
    add_column :listings, :indoor_fireplace, :boolean, default: false
    add_column :listings, :breakfast, :boolean, default: false
    add_column :listings, :kitchen, :boolean, default: false
    add_column :listings, :cable_tv, :boolean, default: false
    add_column :listings, :dryer, :boolean, default: false
    add_column :listings, :hair_dryer, :boolean, default: false
    add_column :listings, :washer, :boolean, default: false
    add_column :listings, :tv, :boolean, default: false
    add_column :listings, :buzzer_wireless_intercom, :boolean, default: false
    add_column :listings, :iron, :boolean, default: false
    add_column :listings, :essentials, :boolean, default: false
    add_column :listings, :laptop_friendly_workspace, :boolean, default: false
    add_column :listings, :heating, :boolean, default: false
    add_column :listings, :private_entrance, :boolean, default: false
  end
end
