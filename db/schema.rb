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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150508041528) do

  create_table "landlords", :force => true do |t|
    t.string   "name"
    t.integer  "rating_count"
    t.decimal  "average_rating"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.decimal  "avg_general"
    t.decimal  "avg_helpfulness"
    t.decimal  "avg_professionalism"
    t.decimal  "avg_credibility"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "rating_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "landlord_id"
    t.integer  "general_1"
    t.integer  "helpfulness_1"
    t.integer  "professionalism_1"
    t.integer  "credibility_1"
    t.string   "comment"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "general_2"
    t.integer  "helpfulness_2"
    t.integer  "professionalism_2"
    t.integer  "credibility_2"
    t.boolean  "oldreview"
  end

  create_table "texts", :force => true do |t|
    t.string "name"
    t.string "text"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "oauth_token"
    t.boolean  "admin"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
