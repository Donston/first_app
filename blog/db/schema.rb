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

ActiveRecord::Schema.define(version: 20140316233932) do

  create_table "blog_posts", force: true do |t|
    t.string   "title",          limit: 100, default: "",  null: false
    t.text     "content",                                  null: false
    t.string   "author",         limit: 100, default: "0", null: false
    t.string   "status",         limit: 20,  default: "",  null: false
    t.integer  "author_id",                  default: 0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",             default: 0,   null: false
  end

  create_table "blog_posts_categories", id: false, force: true do |t|
    t.integer "blog_post_id"
    t.integer "category_id"
  end

  add_index "blog_posts_categories", ["category_id", "blog_post_id"], name: "index_blog_posts_categories_on_category_id_and_blog_post_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name",        limit: 50, default: "", null: false
    t.string   "short_name",  limit: 30, default: "", null: false
    t.string   "description",            default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "blog_post_id",            default: 0,  null: false
    t.string   "author",       limit: 25, default: "", null: false
    t.string   "author_email", limit: 50, default: "", null: false
    t.text     "content",                              null: false
    t.string   "status",       limit: 25, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",         limit: 25, default: "", null: false
    t.string   "hashed_password",  limit: 40, default: "", null: false
    t.string   "first_name",       limit: 25, default: "", null: false
    t.string   "last_name",        limit: 40, default: "", null: false
    t.string   "email",            limit: 50, default: "", null: false
    t.string   "display_name",     limit: 25, default: "", null: false
    t.integer  "user_level",       limit: 3,  default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blog_posts_count",            default: 0,  null: false
    t.string   "salt",             limit: 40
  end

end
