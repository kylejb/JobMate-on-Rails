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

ActiveRecord::Schema.define(version: 2020_07_29_151927) do

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorite_companies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_favorite_companies_on_company_id"
    t.index ["user_id"], name: "index_favorite_companies_on_user_id"
  end

  create_table "postings", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "posting_date"
    t.string "location"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "link"
    t.string "salary"
    t.string "languages"
    t.string "experience"
    t.string "requirements"
    t.index ["company_id"], name: "index_postings_on_company_id"
  end

  create_table "saved_postings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "posting_id", null: false
    t.boolean "super_post", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["posting_id"], name: "index_saved_postings_on_posting_id"
    t.index ["user_id"], name: "index_saved_postings_on_user_id"
  end

  create_table "user_categories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  add_foreign_key "favorite_companies", "companies"
  add_foreign_key "favorite_companies", "users"
  add_foreign_key "postings", "companies"
  add_foreign_key "saved_postings", "postings"
  add_foreign_key "saved_postings", "users"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_categories", "users"
end
