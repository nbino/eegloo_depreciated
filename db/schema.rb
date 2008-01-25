# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 24) do

  create_table "apt_types", :force => true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "attribute_values", :force => true do |t|
    t.string "name"
    t.string "description"
    t.string "type"
  end

  create_table "comments", :force => true do |t|
    t.integer "listing_id"
    t.integer "user_id"
    t.text    "comment"
  end

  create_table "favorites", :force => true do |t|
    t.integer "user_id",     :null => false
    t.integer "listing_id",  :null => false
    t.string  "description"
    t.integer "position"
  end

  create_table "flags", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "listing_id",  :null => false
    t.string   "description"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", :force => true do |t|
    t.string  "address1"
    t.integer "nhood_id"
    t.integer "apt_type_id"
    t.date    "lease_experation_date"
    t.integer "rent_range_id"
    t.integer "roach_problem"
    t.integer "favorites_count"
    t.integer "user_id"
    t.string  "comment"
  end

  create_table "nhoods", :force => true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "rent_ranges", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.integer "lbound"
    t.integer "ubound"
  end

  create_table "users", :force => true do |t|
    t.string  "name"
    t.string  "login",           :default => "", :null => false
    t.string  "password",        :default => "", :null => false
    t.string  "email"
    t.integer "favorites_count", :default => 0
  end

  create_table "visuals", :force => true do |t|
    t.integer "listing_id"
    t.integer "parent_id"
    t.string  "content_type"
    t.string  "filename"
    t.string  "thumbnail"
    t.integer "size"
    t.integer "width"
    t.integer "height"
    t.string  "comment"
    t.integer "visual_type_id"
  end

end
