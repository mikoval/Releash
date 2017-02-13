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

ActiveRecord::Schema.define(version: 20170212183728) do

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
    t.string   "status"
  end

  create_table "breeds", force: :cascade do |t|
    t.string   "name"
    t.integer  "species_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fosters", force: :cascade do |t|
    t.string   "user_id"
    t.string   "animal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
  end

  create_table "species", force: :cascade do |t|
    t.string   "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.integer  "role_id"
    t.string   "picture"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
