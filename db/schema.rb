# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150927100609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",      precision: 10, scale: 2
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token",   index: {name: "index_users_on_reset_password_token", unique: true}
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "authentication_token",   default: "",    null: false
    t.boolean  "inactive",               default: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "full_name"
    t.string   "phone_number",           index: {name: "index_users_on_phone_number", unique: true}
    t.integer  "role"
    t.text     "avatar"
    t.integer  "gender"
    t.string   "address"
    t.string   "city"
    t.boolean  "notified",               default: false
    t.string   "pincode"
    t.float    "lat"
    t.float    "lon"
    t.string   "gcm_registration",       index: {name: "index_users_on_gcm_registration"}
  end

  create_table "pick_ups", force: :cascade do |t|
    t.string   "pincode"
    t.string   "city"
    t.string   "address"
    t.integer  "parent_id",    index: {name: "index_pick_ups_on_parent_id"}, foreign_key: {references: "pick_ups", name: "fk_pick_ups_parent_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "subscription"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "accepted_at"
    t.datetime "started_at"
    t.datetime "proceeded_at"
    t.text     "category_set", default: [],               array: true
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "lat",          index: {name: "index_pick_ups_on_lat_and_lon", with: ["lon"]}
    t.float    "lon"
    t.integer  "user_id",      index: {name: "index_pick_ups_on_user_id"}, foreign_key: {references: "users", name: "fk_pick_ups_user_id", on_update: :no_action, on_delete: :no_action}
    t.decimal  "total",        precision: 10, scale: 2, default: 0.0
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "category_id", index: {name: "index_line_items_on_category_id"}, foreign_key: {references: "categories", name: "fk_line_items_category_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "pick_up_id",  index: {name: "index_line_items_on_pick_up_id"}, foreign_key: {references: "pick_ups", name: "fk_line_items_pick_up_id", on_update: :no_action, on_delete: :no_action}
    t.float    "quantity"
    t.decimal  "cost_price",  precision: 10, scale: 2
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.decimal  "item_total",  precision: 10, scale: 2, default: 0.0
  end

  create_table "pickup_users", force: :cascade do |t|
    t.integer  "pick_up_id",  index: {name: "index_pickup_users_on_pick_up_id"}, foreign_key: {references: "pick_ups", name: "fk_pickup_users_pick_up_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "user_id",     index: {name: "index_pickup_users_on_user_id"}, foreign_key: {references: "users", name: "fk_pickup_users_user_id", on_update: :no_action, on_delete: :no_action}
    t.string   "type"
    t.string   "reason"
    t.datetime "canceled_at"
    t.datetime "rejected_at"
    t.datetime "accepted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "time_slots", force: :cascade do |t|
    t.integer  "start_hour", null: false
    t.integer  "end_hour",   null: false
    t.boolean  "inactive",   default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
