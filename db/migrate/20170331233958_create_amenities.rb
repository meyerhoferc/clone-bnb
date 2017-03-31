class CreateAmenities < ActiveRecord::Migration[5.0]
  def change
    create_table :amenities do |t|
      t.boolean :elevator, default: false
      t.boolean :pets_allowed, default: false
      t.boolean :free_parking, default: false
      t.boolean :family_kid_friendly, default: false
      t.boolean :doorman, default: false
      t.boolean :pool, default: false
      t.boolean :hot_tub, default: false
      t.boolean :gym, default: false
      t.boolean :air_conditioning, default: false
      t.boolean :wheelchair_accessible, default: false
      t.boolean :internet, default: false
      t.boolean :smoking_allowed, default: false
      t.boolean :suitable_for_events, default: false
      t.boolean :wireless_internet, default: false
      t.boolean :indoor_fireplace, default: false
      t.boolean :breakfast, default: false
      t.boolean :kitchen, default: false
      t.boolean :cable_tv, default: false
      t.boolean :dryer, default: false
      t.boolean :hair_dryer, default: false
      t.boolean :washer, default: false
      t.boolean :tv, default: false
      t.boolean :buzzer_wireless_intercom, default: false
      t.boolean :iron, default: false
      t.boolean :essentials, default: false
      t.boolean :laptop_friendly_workspace, default: false
      t.boolean :heating, default: false
      t.boolean :private_entrance, default: false
    end
  end
end
