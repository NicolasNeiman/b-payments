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

ActiveRecord::Schema.define(version: 2020_12_02_170640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchange_rates", force: :cascade do |t|
    t.string "date"
    t.string "currency_in"
    t.string "currency_out"
    t.float "exchange_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.integer "bitcoin_amount_cents", default: 0, null: false
    t.string "bitcoin_amount_currency", default: "BTC", null: false
    t.string "url"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "coinbase_token"
    t.boolean "coinbase_token_expires"
    t.integer "coinbase_token_expires_at"
    t.string "coinbase_refresh_token"
    t.string "coinbase_paypal_account_id"
    t.string "authentication_token", limit: 30
    t.string "coinbase_eur_account_id"
    t.string "coinbase_eur_payment_method_id"
    t.string "coinbase_btc_account_id"
    t.boolean "admin", default: false, null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "transactions", "users"
end
