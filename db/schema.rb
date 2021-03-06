# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_10_172353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "non_recurring_items", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "type", null: false
    t.datetime "date", null: false
    t.float "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date"], name: "index_non_recurring_items_on_date"
    t.index ["type"], name: "index_non_recurring_items_on_type"
    t.index ["user_id"], name: "index_non_recurring_items_on_user_id"
  end

  create_table "recurring_items", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "type", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.integer "recur_period"
    t.string "recur_unit_type", null: false
    t.float "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_date"], name: "index_recurring_items_on_end_date"
    t.index ["recur_period"], name: "index_recurring_items_on_recur_period"
    t.index ["start_date"], name: "index_recurring_items_on_start_date"
    t.index ["type"], name: "index_recurring_items_on_type"
    t.index ["user_id"], name: "index_recurring_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "session_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
