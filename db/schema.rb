# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170316132530) do

  create_table "adopteds", force: :cascade do |t|
    t.string  "adopt_date"
    t.integer "adopter_id"
    t.string  "comments"
    t.integer "animal_id"
  end

  create_table "adopters", force: :cascade do |t|
    t.string  "name"
    t.string  "street"
    t.string  "city"
    t.integer "zip_code"
    t.string  "phone_number"
    t.string  "email_add"
  end

  create_table "alert_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alerts", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "date"
    t.integer  "alert_type_id"
    t.integer  "assignee_id"
    t.integer  "created_by_id"
    t.integer  "animal_id"
    t.string   "location"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "ani_sleeps", force: :cascade do |t|
    t.string  "sleep_date"
    t.string  "comments"
    t.integer "animal_id"
  end

  create_table "ani_transfers", force: :cascade do |t|
    t.string  "transfer_date"
    t.string  "comments"
    t.integer "animal_id"
  end

  create_table "animal_alerts", force: :cascade do |t|
    t.integer  "animal_id"
    t.integer  "alert_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "animal_breeds", force: :cascade do |t|
    t.integer  "animal_id"
    t.integer  "breed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "animal_characteristics", force: :cascade do |t|
    t.integer  "animal_id"
    t.integer  "characteristic_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "animals", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "species_id"
    t.string   "picture"
    t.string   "color_primary"
    t.string   "color_secondary"
    t.string   "eye_color"
    t.string   "adoption_fee"
    t.string   "animal_type"
    t.string   "birthday"
    t.string   "gender"
    t.integer  "cage_number"
    t.integer  "microchip_number"
    t.integer  "tag_number"
    t.integer  "neutered"
    t.integer  "primary_breed_id"
    t.integer  "secondary_breed_id"
    t.string   "intake_document"
    t.string   "owner_surrender_document"
    t.string   "home_check_document"
    t.string   "match_application_document"
    t.string   "adoption_application_document"
    t.string   "adoption_contract_document"
    t.string   "vetting_document"
    t.integer  "status_id"
  end

  create_table "breeds", force: :cascade do |t|
    t.string   "name"
    t.integer  "species_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characteristics", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foster_stages", force: :cascade do |t|
    t.string  "foster_date"
    t.integer "curr_fost_id"
    t.string  "comment"
    t.integer "fost_hold_id"
    t.integer "animal_id"
  end

  create_table "fosters", force: :cascade do |t|
    t.string   "user_id"
    t.string   "animal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hold_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "updated_at", null: false
  end

  create_table "illnesses", force: :cascade do |t|
    t.string  "ill_date"
    t.integer "ill_vet_id"
    t.string  "ill_info"
    t.string  "comments"
    t.integer "animal_id"
  end

  create_table "intakes", force: :cascade do |t|
    t.string  "intake_date"
    t.integer "foster_id"
    t.integer "vet_id"
    t.string  "comments"
    t.integer "intake_hold_id"
    t.integer "animal_id"
  end

  create_table "other_holds", force: :cascade do |t|
    t.string  "other_date"
    t.string  "comments"
    t.integer "animal_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
  end

  create_table "species", force: :cascade do |t|
    t.string   "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "updated_at", null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.string  "train_date"
    t.string  "problem_info"
    t.decimal "expense"
    t.integer "animal_id"
  end

  create_table "user_alerts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "alert_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                                                                                                                                                                                                                                                                                                                                null: false
    t.datetime "updated_at",                                                                                                                                                                                                                                                                                                                                                null: false
    t.string   "password_digest"
    t.integer  "role_id"
    t.string   "picture"
    t.string   "remember_digest"
    t.boolean  "disabled",          default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "dashboard",         default: "[{\"type\":\"animal-list\", \"x\":0, \"y\":0, \"height\": 4 , \"width\": 5},\n    {\"type\":\"user-list\", \"x\":5, \"y\":0, \"height\": 4 , \"width\": 5},\n    {\"type\":\"alert-list\", \"x\":0, \"y\":5, \"height\": 4 , \"width\": 5},\n    {\"type\":\"new-widget\", \"x\":5, \"y\":5, \"height\": 4 , \"width\": 5}]"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "veterinarian", force: :cascade do |t|
    t.string  "name"
    t.string  "street"
    t.string  "city"
    t.string  "state"
    t.integer "zip_code"
  end

  create_table "vettings", force: :cascade do |t|
    t.string  "vet_date"
    t.integer "curr_vet_id"
    t.integer "curr_fost_id"
    t.string  "comments"
    t.integer "vet_hold_id"
    t.integer "animal_id"
  end

end
