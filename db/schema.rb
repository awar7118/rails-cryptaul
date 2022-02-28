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

ActiveRecord::Schema.define(version: 2022_02_28_220944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "baskets", force: :cascade do |t|
    t.float "total_price"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_baskets_on_user_id"
  end

  create_table "cryptos", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "abbreviation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_products", force: :cascade do |t|
    t.float "fixed_price"
    t.integer "quantity"
    t.bigint "basket_id", null: false
    t.bigint "crypto_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["basket_id"], name: "index_order_products_on_basket_id"
    t.index ["crypto_id"], name: "index_order_products_on_crypto_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.float "purchased_price"
    t.integer "quantity"
    t.bigint "user_id", null: false
    t.bigint "crypto_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crypto_id"], name: "index_purchases_on_crypto_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "watchlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "crypto_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crypto_id"], name: "index_watchlists_on_crypto_id"
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

  add_foreign_key "baskets", "users"
  add_foreign_key "order_products", "baskets"
  add_foreign_key "order_products", "cryptos"
  add_foreign_key "purchases", "cryptos"
  add_foreign_key "purchases", "users"
  add_foreign_key "watchlists", "cryptos"
  add_foreign_key "watchlists", "users"
end
