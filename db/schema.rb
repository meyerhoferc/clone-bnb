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

ActiveRecord::Schema.define(version: 20170403175008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "amenities", force: :cascade do |t|
    t.string "name"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "initiator_id"
    t.integer "recipient_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "image_url"
    t.integer  "listing_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["listing_id"], name: "index_images_on_listing_id", using: :btree
  end

  create_table "listing_amenities", force: :cascade do |t|
    t.integer "listing_id"
    t.integer "amenity_id"
    t.boolean "value",      default: false
    t.index ["amenity_id"], name: "index_listing_amenities_on_amenity_id", using: :btree
    t.index ["listing_id"], name: "index_listing_amenities_on_listing_id", using: :btree
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
    t.integer "cost_per_night", default: 0
    t.integer "number_baths"
    t.index ["user_id"], name: "index_listings_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text    "body"
    t.integer "conversation_id"
    t.integer "user_id"
    t.boolean "unread"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
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

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.integer  "stars"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "listing_id"
    t.index ["listing_id"], name: "index_reviews_on_listing_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_user_roles_on_role_id", using: :btree
    t.index ["user_id"], name: "index_user_roles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "about_me"
    t.string   "phone_number"
    t.string   "password_digest"
    t.integer  "status",              default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_foreign_key "images", "listings", on_delete: :cascade
  add_foreign_key "listing_amenities", "amenities"
  add_foreign_key "listing_amenities", "listings"
  add_foreign_key "listings", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "reservations", "listings"
  add_foreign_key "reservations", "users"
  add_foreign_key "reviews", "listings"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
