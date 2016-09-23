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

ActiveRecord::Schema.define(version: 20160923145017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reservations", force: :cascade do |t|
    t.date     "bookingdate"
    t.time     "starttime"
    t.time     "endtime"
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "reservations", ["room_id"], name: "index_reservations_on_room_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "roomadds", force: :cascade do |t|
    t.string   "room_no"
    t.string   "size"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roomadds", ["user_id"], name: "index_roomadds_on_user_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.string   "location"
    t.string   "size"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userlogins", force: :cascade do |t|
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

  add_index "userlogins", ["email"], name: "index_userlogins_on_email", unique: true, using: :btree
  add_index "userlogins", ["reset_password_token"], name: "index_userlogins_on_reset_password_token", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "isAdmin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_foreign_key "reservations", "rooms"
  add_foreign_key "reservations", "users"
  add_foreign_key "roomadds", "users"
end
