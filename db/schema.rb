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

ActiveRecord::Schema.define(version: 20170620043012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gender_no_indices", force: :cascade do |t|
    t.string   "name",                               default: "",    null: false
    t.decimal  "male",       precision: 8, scale: 6, default: "0.0", null: false
    t.decimal  "female",     precision: 8, scale: 6, default: "0.0", null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "genders", force: :cascade do |t|
    t.string   "name",                               default: "",    null: false
    t.decimal  "male",       precision: 8, scale: 6, default: "0.0", null: false
    t.decimal  "female",     precision: 8, scale: 6, default: "0.0", null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.index ["female"], name: "index_genders_on_female", using: :btree
    t.index ["male"], name: "index_genders_on_male", using: :btree
    t.index ["name"], name: "index_genders_on_name", using: :btree
  end

  create_table "logins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "login_attempts"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_id"], name: "index_logins_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
