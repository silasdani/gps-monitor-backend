# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_07_201655) do

  create_table "locations", force: :cascade do |t|
    t.string "location_title"
    t.integer "street_number"
    t.string "locality"
    t.integer "postal_code"
    t.string "latitude"
    t.string "longitude"
    t.string "place_id"
    t.string "country"
    t.string "facility_name"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_locations_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.datetime "date"
    t.float "distance"
    t.integer "time"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "av_speed", default: 0.0
    t.string "location"
    t.index ["user_id", "created_at"], name: "index_tracks_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_tracks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.boolean "manager", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "locations", "users"
  add_foreign_key "tracks", "users"
end
