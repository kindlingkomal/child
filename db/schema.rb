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

ActiveRecord::Schema.define(version: 20151114015759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",      precision: 10, scale: 2
    t.string   "image"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "categories_pick_ups", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "pick_up_id"
  end

  add_index "categories_pick_ups", ["category_id"], name: "index_categories_pick_ups_on_category_id", using: :btree
  add_index "categories_pick_ups", ["pick_up_id"], name: "index_categories_pick_ups_on_pick_up_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "invited_by_id"
    t.string   "name"
    t.string   "phone_number"
    t.datetime "accepted_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "invitations", ["invited_by_id"], name: "index_invitations_on_invited_by_id", using: :btree
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "pick_up_id"
    t.float    "quantity"
    t.decimal  "cost_price",  precision: 10, scale: 2
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "name"
    t.decimal  "item_total",  precision: 10, scale: 2, default: 0.0
  end

  add_index "line_items", ["category_id"], name: "index_line_items_on_category_id", using: :btree
  add_index "line_items", ["pick_up_id"], name: "index_line_items_on_pick_up_id", using: :btree

  create_table "mobile_devices", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "platform"
    t.boolean  "disabled"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifying_pickups", force: :cascade do |t|
    t.integer  "pick_up_id"
    t.integer  "ragpicker_id"
    t.datetime "sent_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "notifying_pickups", ["pick_up_id"], name: "index_notifying_pickups_on_pick_up_id", using: :btree
  add_index "notifying_pickups", ["ragpicker_id"], name: "index_notifying_pickups_on_ragpicker_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "zipcode"
    t.string   "city"
    t.string   "address"
    t.string   "repeat"
    t.date     "pick_date"
    t.datetime "pick_from_time"
    t.datetime "pick_to_time"
    t.float    "lat"
    t.float    "lon"
    t.boolean  "inactive",       default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "pick_ups", force: :cascade do |t|
    t.string   "pincode"
    t.string   "city"
    t.string   "address"
    t.integer  "subscription"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "accepted_at"
    t.datetime "canceled_at"
    t.datetime "proceeded_at"
    t.text     "category_set",                          default: [],                 array: true
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.float    "lat"
    t.float    "lon"
    t.integer  "user_id"
    t.decimal  "total",        precision: 10, scale: 2, default: 0.0
    t.integer  "customer_id"
    t.integer  "order_id"
    t.integer  "ragpicker_id"
    t.string   "code"
    t.string   "status"
    t.boolean  "manual",                                default: false
  end

  add_index "pick_ups", ["customer_id"], name: "index_pick_ups_on_customer_id", using: :btree
  add_index "pick_ups", ["lat", "lon"], name: "index_pick_ups_on_lat_and_lon", using: :btree
  add_index "pick_ups", ["user_id"], name: "index_pick_ups_on_user_id", using: :btree

  create_table "pickup_users", force: :cascade do |t|
    t.integer  "pick_up_id"
    t.integer  "user_id"
    t.string   "type"
    t.string   "reason"
    t.datetime "canceled_at"
    t.datetime "rejected_at"
    t.datetime "accepted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "status"
  end

  add_index "pickup_users", ["pick_up_id"], name: "index_pickup_users_on_pick_up_id", using: :btree
  add_index "pickup_users", ["user_id"], name: "index_pickup_users_on_user_id", using: :btree

  create_table "pricing_zonals", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "zonal_id"
    t.string   "category_name"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "pricing_zonals", ["category_id", "zonal_id"], name: "index_pricing_zonals_on_category_id_and_zonal_id", using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rateable_type", "rateable_id"], name: "fk__rates_rateable_id", using: :btree
  add_index "rates", ["rater_id"], name: "fk__rates_rater_id", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree
  add_index "rating_caches", ["cacheable_type", "cacheable_id"], name: "fk__rating_caches_cacheable_id", using: :btree

  create_table "time_slots", force: :cascade do |t|
    t.integer  "start_hour",                 null: false
    t.integer  "end_hour",                   null: false
    t.boolean  "inactive",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "authentication_token",   default: "",    null: false
    t.boolean  "inactive",               default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "full_name"
    t.string   "phone_number"
    t.integer  "role"
    t.text     "avatar"
    t.integer  "gender"
    t.string   "address"
    t.string   "city"
    t.boolean  "notified",               default: false
    t.string   "pincode"
    t.float    "lat"
    t.float    "lon"
    t.string   "gcm_registration"
  end

  add_index "users", ["gcm_registration"], name: "index_users_on_gcm_registration", using: :btree
  add_index "users", ["phone_number"], name: "index_users_on_phone_number", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "zonals", force: :cascade do |t|
    t.string   "zipcode"
    t.float    "lat"
    t.float    "lon"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "invitations", "users", column: "invited_by_id", name: "fk_invitations_invited_by_id"
  add_foreign_key "invitations", "users", name: "fk_invitations_user_id"
  add_foreign_key "line_items", "categories", name: "fk_line_items_category_id"
  add_foreign_key "line_items", "pick_ups", name: "fk_line_items_pick_up_id"
  add_foreign_key "notifying_pickups", "pick_ups"
  add_foreign_key "notifying_pickups", "users", column: "ragpicker_id"
  add_foreign_key "pick_ups", "customers", name: "fk_pick_ups_customer_id"
  add_foreign_key "pick_ups", "users", name: "fk_pick_ups_user_id"
  add_foreign_key "pickup_users", "pick_ups", name: "fk_pickup_users_pick_up_id"
  add_foreign_key "pickup_users", "users", name: "fk_pickup_users_user_id"
  add_foreign_key "rates", "users", column: "rater_id", name: "fk_rates_rater_id"
end
