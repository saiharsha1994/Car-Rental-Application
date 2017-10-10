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

ActiveRecord::Schema.define(version: 20171010000505) do

  create_table "cars", force: :cascade do |t|
    t.string "model"
    t.string "manufacturer"
    t.string "status"
    t.string "lic_no"
    t.integer "hourly_rate"
    t.string "style"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emailtos", force: :cascade do |t|
    t.string "user_id"
    t.string "email"
    t.string "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "model"
    t.string "lic_no"
    t.string "manufacturer"
    t.string "hourly_rate"
    t.string "style"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "car_id"
    t.integer "user_id"
    t.date "checkout_date"
    t.date "return_date"
    t.time "checkout_time"
    t.time "return_time"
    t.time "actual_return_time"
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
  end

  create_table "suggestions", force: :cascade do |t|
    t.string "model"
    t.string "manufacture"
    t.string "status"
    t.string "lic_no"
    t.string "hourly_rate"
    t.string "style"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
