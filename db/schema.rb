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

ActiveRecord::Schema.define(version: 20131107185332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_infos", force: true do |t|
    t.string   "ip"
    t.string   "browser"
    t.string   "version"
    t.string   "platform"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "access_infos_users", force: true do |t|
    t.integer "user_id"
    t.integer "access_info_id"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.datetime "published_at"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "articles_tags", force: true do |t|
    t.integer "article_id"
    t.integer "tag_id"
  end

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "text"
    t.string   "ancestry"
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree
  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "images", force: true do |t|
    t.string   "image"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "karmas", force: true do |t|
    t.integer  "user_id"
    t.integer  "value",         default: 0
    t.integer  "karmable_id"
    t.string   "karmable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "karmas", ["user_id"], name: "index_karmas_on_user_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "email"
    t.string   "remember_token"
    t.string   "role"
    t.datetime "banned_at"
    t.string   "avatar_url"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
