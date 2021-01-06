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

ActiveRecord::Schema.define(version: 2021_01_06_140144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collect_links", force: :cascade do |t|
    t.string "collect_code", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["collect_code"], name: "index_collect_links_on_collect_code", unique: true
    t.index ["user_id"], name: "index_collect_links_on_user_id"
  end

  create_table "testimonials", force: :cascade do |t|
    t.string "user_name"
    t.string "user_company"
    t.string "user_role"
    t.string "user_link"
    t.text "user_testimonial"
    t.bigint "user_id", null: false
    t.boolean "is_a_tweet", default: false, null: false
    t.string "tweet_status_id"
    t.text "tweet_url"
    t.string "tweet_user_id"
    t.text "tweet_image_url"
    t.index ["user_id"], name: "index_testimonials_on_user_id"

    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "company_name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "collect_links", "users"
  add_foreign_key "testimonials", "users"
end
