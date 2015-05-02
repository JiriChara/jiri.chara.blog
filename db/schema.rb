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

ActiveRecord::Schema.define(version: 20150502211117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_infos", force: :cascade do |t|
    t.string   "ip",         limit: 255
    t.string   "browser",    limit: 255
    t.string   "version",    limit: 255
    t.string   "platform",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country",    limit: 255
    t.string   "city",       limit: 255
  end

  create_table "access_infos_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "access_info_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "slug",         limit: 255
    t.text     "content"
    t.datetime "published_at"
    t.string   "type",         limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "articles_tags", force: :cascade do |t|
    t.integer "article_id"
    t.integer "tag_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.string   "ancestry",   limit: 255
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree
  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "karmas", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "value",                     default: 0
    t.integer  "karmable_id"
    t.string   "karmable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "karmas", ["user_id"], name: "index_karmas_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "slug",           limit: 255
    t.string   "email",          limit: 255
    t.string   "remember_token", limit: 255
    t.string   "role",           limit: 255
    t.datetime "banned_at"
    t.string   "avatar_url",     limit: 255
    t.string   "time_zone",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
  end

end
