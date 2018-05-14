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

ActiveRecord::Schema.define(version: 20180513231317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carted_donation_items", force: :cascade do |t|
    t.string   "status"
    t.integer  "quantity"
    t.integer  "order_id"
    t.integer  "donation_item_id"
    t.string   "session_id"
    t.decimal  "price",            precision: 7, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "donation_items", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",       precision: 7, scale: 2
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "ref_num"
    t.string   "email"
    t.decimal  "total",      precision: 7, scale: 2
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "token"
    t.boolean  "recurring",                          default: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.datetime "date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
