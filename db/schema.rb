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

ActiveRecord::Schema.define(version: 2018_09_07_193106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.string "ABTANumber"
    t.string "token"
    t.date "ArrivalDate"
    t.integer "Nights"
    t.string "RoomCode"
    t.integer "Adults"
    t.integer "Children"
    t.integer "ParkingDays"
    t.string "Title"
    t.string "Initial"
    t.string "Surname"
    t.string "Address"
    t.string "Town"
    t.string "County"
    t.string "PostCode"
    t.integer "DayPhone"
    t.string "Email"
    t.string "CustomerRef"
    t.text "Remarks"
    t.boolean "Waiver"
    t.string "DataProtection"
    t.string "PriceCheckFlag"
    t.float "PriceCheckPrice"
    t.string "System"
    t.string "lang"
    t.string "SecondRoomType"
    t.string "SecondRoomCode"
    t.integer "SecondRoomAdults"
    t.integer "SecondRoomChildren"
    t.boolean "active", default: true
    t.boolean "success", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "formatted_address"
    t.decimal "lat", precision: 15, scale: 13
    t.decimal "lng", precision: 15, scale: 13
    t.string "post_code"
    t.string "city"
    t.string "country"
    t.string "rating"
    t.string "website"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_destinations_on_trip_id"
  end

  create_table "parkings", force: :cascade do |t|
    t.date "ArrivalDate"
    t.time "ArrivalTime"
    t.date "DepartDate"
    t.time "DepartTime"
    t.integer "NumberOfPax"
    t.string "Title"
    t.string "Initial"
    t.string "Surname"
    t.string "Email"
    t.string "Waiver"
    t.string "Remarks"
    t.string "ABTANumber"
    t.boolean "active", default: true
    t.boolean "success", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_parkings_on_user_id"
  end

  create_table "todos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_todos_on_trip_id"
  end

  create_table "trips", id: :serial, force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "departure_airport_code"
    t.string "arrival_airport_code"
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.string "email"
    t.boolean "admin", default: false
    t.boolean "member", default: true
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "token_created_at"
    t.index ["token", "token_created_at"], name: "index_users_on_token_and_token_created_at"
  end

  add_foreign_key "bookings", "users"
  add_foreign_key "destinations", "trips"
  add_foreign_key "parkings", "users"
  add_foreign_key "todos", "trips"
  add_foreign_key "trips", "users"
end
