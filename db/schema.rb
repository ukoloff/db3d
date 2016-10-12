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

ActiveRecord::Schema.define(version: 20161012091202) do

  create_table "fotos", force: :cascade do |t|
    t.integer  "tool_id"
    t.string   "name"
    t.string   "mime"
    t.binary   "blob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
  end

  create_table "oauths", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.text     "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "oauths", ["provider", "uid"], name: "index_oauths_on_provider_and_uid"
  add_index "oauths", ["user_id"], name: "index_oauths_on_user_id"

  create_table "t2ts", force: :cascade do |t|
    t.integer  "tool_id",    null: false
    t.integer  "tag_id",     null: false
    t.integer  "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "t2ts", ["tag_id", "tool_id"], name: "index_t2ts_on_tag_id_and_tool_id", unique: true
  add_index "t2ts", ["tool_id"], name: "index_t2ts_on_tool_id"

  create_table "tags", force: :cascade do |t|
    t.text     "name",       null: false
    t.integer  "creator_id"
    t.datetime "expire_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name"

  create_table "tools", force: :cascade do |t|
    t.string   "name"
    t.text     "note"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string   "author"
    t.integer  "creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

end
