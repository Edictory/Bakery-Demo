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

ActiveRecord::Schema[7.0].define(version: 2025_02_28_010637) do
  create_table "addresses", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.boolean "is_billing"
    t.string "recipient"
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.boolean "active", default: true
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.boolean "active", default: true
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "ssn", null: false
    t.date "date_hired", null: false
    t.date "date_terminated"
    t.integer "user_id", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "item_prices", force: :cascade do |t|
    t.integer "item_id", null: false
    t.float "price", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_prices_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "category", null: false
    t.integer "units_per_item", null: false
    t.float "weight", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "item_id", null: false
    t.integer "quantity", null: false
    t.date "shipped_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "address_id", null: false
    t.date "date"
    t.float "grand_total"
    t.string "payment_receipt"
    t.bigint "credit_card_number"
    t.integer "expiration_year"
    t.integer "expiration_month"
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest"
    t.integer "role", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "customers", "users"
  add_foreign_key "employees", "users"
  add_foreign_key "item_prices", "items"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "customers"
end
