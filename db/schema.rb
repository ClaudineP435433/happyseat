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

ActiveRecord::Schema.define(version: 20180227142237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "participants", force: :cascade do |t|
    t.bigint "seating_plan_id"
    t.string "first_name"
    t.string "last_name"
    t.integer "age_range"
    t.integer "seat"
    t.integer "family_type"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seating_plan_id"], name: "index_participants_on_seating_plan_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "link"
    t.bigint "first_guest_id"
    t.bigint "second_guest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_guest_id"], name: "index_relationships_on_first_guest_id"
    t.index ["second_guest_id"], name: "index_relationships_on_second_guest_id"
  end

  create_table "seating_plans", force: :cascade do |t|
    t.string "name"
    t.integer "nb_participants"
    t.string "wedding_address"
    t.date "wedding_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "nb_tables"
    t.integer "nb_max_participants"
    t.index ["user_id"], name: "index_seating_plans_on_user_id"
  end

  create_table "tables", force: :cascade do |t|
    t.string "name"
    t.integer "nb_max_participants"
    t.bigint "seating_plan_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seating_plan_id"], name: "index_tables_on_seating_plan_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "groom_first_name"
    t.string "groom_last_name"
    t.string "bride_first_name"
    t.string "bride_last_name"
    t.string "address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "participants", "seating_plans"
  add_foreign_key "seating_plans", "users"
  add_foreign_key "tables", "seating_plans"
end
