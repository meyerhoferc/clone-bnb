# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170331054914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "images", force: :cascade do |t|
    t.string  "image_url"
    t.integer "listing_id"
    t.index ["listing_id"], name: "index_images_on_listing_id", using: :btree
  end

  create_table "listings", force: :cascade do |t|
    t.integer "user_id"
    t.citext  "street_address"
    t.string  "description"
    t.citext  "city"
    t.citext  "state"
    t.string  "zipcode"
    t.string  "max_occupancy"
    t.citext  "title"
    t.string  "list_category"
    t.string  "number_beds"
    t.string  "number_rooms"
    t.boolean "number_baths",              default: false
    t.boolean "elevator",                  default: false
    t.boolean "pets_allowed",              default: false
    t.boolean "free_parking",              default: false
    t.boolean "family_kid_friendly",       default: false
    t.boolean "doorman",                   default: false
    t.boolean "pool",                      default: false
    t.boolean "hot_tub",                   default: false
    t.boolean "gym",                       default: false
    t.boolean "air_conditioning",          default: false
    t.boolean "wheelchair_accessible",     default: false
    t.boolean "internet",                  default: false
    t.boolean "smoking_allowed",           default: false
    t.boolean "suitable_for_events",       default: false
    t.boolean "wireless_internet",         default: false
    t.boolean "indoor_fireplace",          default: false
    t.boolean "breakfast",                 default: false
    t.boolean "kitchen",                   default: false
    t.boolean "cable_tv",                  default: false
    t.boolean "dryer",                     default: false
    t.boolean "hair_dryer",                default: false
    t.boolean "washer",                    default: false
    t.boolean "tv",                        default: false
    t.boolean "buzzer_wireless_intercom",  default: false
    t.boolean "iron",                      default: false
    t.boolean "essentials",                default: false
    t.boolean "laptop_friendly_workspace", default: false
    t.boolean "heating",                   default: false
    t.boolean "private_entrance",          default: false
    t.integer "cost_per_night",            default: 0
    t.index ["user_id"], name: "index_listings_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer "host_id"
    t.integer "traveler_id"
    t.text    "body"
    t.string  "title"
  end

  create_table "reservations", force: :cascade do |t|
    t.date    "start_date"
    t.date    "end_date"
    t.integer "listing_id"
    t.integer "user_id"
    t.integer "status",     default: 0
    t.index ["listing_id"], name: "index_reservations_on_listing_id", using: :btree
    t.index ["user_id"], name: "index_reservations_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.integer "listing_id"
    t.index ["listing_id"], name: "index_user_roles_on_listing_id", using: :btree
    t.index ["role_id"], name: "index_user_roles_on_role_id", using: :btree
    t.index ["user_id"], name: "index_user_roles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "about_me"
    t.string "user_photo"
    t.string "phone_number"
    t.string "password_digest"
  end

  add_foreign_key "images", "listings"
  add_foreign_key "listings", "users"
  add_foreign_key "reservations", "listings"
  add_foreign_key "reservations", "users"
  add_foreign_key "user_roles", "listings"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
