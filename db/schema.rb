ActiveRecord::Schema.define(version: 2021_01_05_155838) do

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
    t.string "user_testimonial"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_testimonials_on_user_id"
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
