# this is all of the tables that are defined. dont define new tables here, create a new model or make a migration script that does it for you. 
# this will get updated as you make changes. 


ActiveRecord::Schema.define(version: 20161122012836) do

  create_table "animals", force: :cascade do |t|
    t.text     "name"
    t.text     "species"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
  end

  create_table "test", id: false, force: :cascade do |t|
    t.string  "name"
    t.integer "price"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.integer  "role"
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
