# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_09_032649) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "department_id"
    t.date "purchase_date"
    t.date "arrival_date"
    t.bigint "vendor_id"
    t.integer "quantity"
    t.float "price_per_unit"
    t.string "image_url"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_stocks_on_department_id"
    t.index ["item_id"], name: "index_stocks_on_item_id"
    t.index ["vendor_id"], name: "index_stocks_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
