# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150203095800) do

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "phonebook_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fb"
    t.string   "twitter"
    t.string   "github"
    t.string   "google_plus"
  end

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.string   "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mobiles", :force => true do |t|
    t.string   "details"
    t.string   "mtype"
    t.string   "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "other_connections", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "connection_type"
    t.string   "connection_detail"
    t.integer  "contact_id"
  end

  create_table "phonebooks", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.string   "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
