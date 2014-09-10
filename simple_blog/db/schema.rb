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

ActiveRecord::Schema.define(version: 20140226161326) do

  create_table "categories", force: true do |t|
    t.string   "name",        limit: 50, default: "", null: false
    t.string   "short_name",  limit: 30, default: "", null: false
    t.string   "description",            default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_posts", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "post_id"
  end

  add_index "categories_posts", ["post_id", "category_id"], name: "index_categories_posts_on_post_id_and_category_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "post_id",                 default: 0,  null: false
    t.string   "author",       limit: 25, default: "", null: false
    t.string   "author_email", limit: 50, default: "", null: false
    t.text     "content",                              null: false
    t.string   "status",       limit: 25, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title",          limit: 100, default: "",  null: false
    t.text     "content",                                  null: false
    t.string   "author",         limit: 100, default: "0", null: false
    t.string   "status",         limit: 20,  default: "",  null: false
    t.integer  "author_id",                  default: 0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",             default: 0,   null: false
  end

  create_table "users", force: true do |t|
    t.string   "username",        limit: 25, default: "", null: false
    t.string   "hashed_password", limit: 40, default: "", null: false
    t.string   "first_name",      limit: 25, default: "", null: false
    t.string   "last_name",       limit: 40, default: "", null: false
    t.string   "email",           limit: 50, default: "", null: false
    t.string   "display_name",    limit: 25, default: "", null: false
    t.integer  "user_level",      limit: 3,  default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count",                default: 0,  null: false
  end

end
