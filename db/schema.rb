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

ActiveRecord::Schema.define(version: 20190228183527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gardens", force: :cascade do |t|
    t.string "zip_code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lat"
    t.string "long"
    t.jsonb "weather_data"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.float "times_per_week"
    t.bigint "garden_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "thumbnail_file_name"
    t.string "thumbnail_content_type"
    t.bigint "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.index ["garden_id"], name: "index_plants_on_garden_id"
  end

  create_table "user_gardens", force: :cascade do |t|
    t.integer "relationship_type", default: 0
    t.bigint "garden_id"
    t.bigint "user_id"
    t.index ["garden_id"], name: "index_user_gardens_on_garden_id"
    t.index ["user_id"], name: "index_user_gardens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "google_token"
    t.string "google_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "telephone"
    t.integer "role", default: 0
    t.boolean "receives_emails", default: true
    t.boolean "receives_texts", default: false
    t.boolean "rainy_day_notifications", default: false
    t.boolean "frost_notifications", default: false
    t.boolean "missed_watering_notifications", default: true
  end

  create_table "waterings", force: :cascade do |t|
    t.datetime "water_time"
    t.boolean "completed", default: false
    t.bigint "plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_waterings_on_plant_id"
  end

  create_table "zipcodes", force: :cascade do |t|
    t.string "zip_code"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "plants", "gardens"
  add_foreign_key "user_gardens", "gardens"
  add_foreign_key "user_gardens", "users"
  add_foreign_key "waterings", "plants"
end
