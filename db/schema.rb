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

ActiveRecord::Schema.define(:version => 20111021113307) do

  create_table "complaints", :force => true do |t|
    t.integer  "entry_id",   :null => false
    t.string   "ip_address", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "complaints", ["entry_id"], :name => "index_complaints_on_entry_id"
  add_index "complaints", ["ip_address"], :name => "index_complaints_on_ip_address"

  create_table "entries", :force => true do |t|
    t.text     "body",               :default => "",    :null => false
    t.string   "photo_file_name",    :default => "",    :null => false
    t.string   "photo_content_type", :default => "",    :null => false
    t.integer  "photo_file_size",    :default => 0,     :null => false
    t.datetime "photo_updated_at"
    t.string   "photo_fingerprint"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "replies_count",      :default => 0,     :null => false
    t.integer  "complaints_count",   :default => 0,     :null => false
    t.boolean  "censored",           :default => false, :null => false
  end

  add_index "entries", ["created_at"], :name => "index_entries_on_created_at"
  add_index "entries", ["parent_id"], :name => "index_entries_on_parent_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
