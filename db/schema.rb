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

ActiveRecord::Schema.define(:version => 20111021101707) do

  create_table "entries", :force => true do |t|
    t.text     "body",               :default => "", :null => false
    t.string   "photo_file_name",    :default => "", :null => false
    t.string   "photo_content_type", :default => "", :null => false
    t.integer  "photo_file_size",    :default => 0,  :null => false
    t.datetime "photo_updated_at"
    t.string   "photo_fingerprint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["created_at"], :name => "index_entries_on_created_at"

end
