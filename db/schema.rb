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

ActiveRecord::Schema.define(version: 20151221081710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audit_logs", force: :cascade do |t|
    t.integer  "moderator_id"
    t.string   "item_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.string   "target_display"
    t.string   "target_url"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "note"
  end

  create_table "daily_digests", force: :cascade do |t|
    t.boolean  "sent"
    t.string   "bucket"
    t.json     "contents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text     "body",                           null: false
    t.boolean  "anonymous",      default: false
    t.integer  "project_id",                     null: false
    t.integer  "user_id"
    t.string   "anon_user_hash"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "list_subscribers", force: :cascade do |t|
    t.string   "email",                        null: false
    t.boolean  "subscribed",   default: true
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "confirmed",    default: false
    t.string   "confirm_code"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",                            null: false
    t.string   "description",                     null: false
    t.string   "url",                             null: false
    t.string   "normalized_url",                  null: false
    t.string   "bucket",                          null: false
    t.string   "slug",                            null: false
    t.integer  "user_id",                         null: false
    t.boolean  "hidden",          default: false
    t.integer  "votes_count",     default: 0
    t.integer  "feedbacks_count", default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "projects", ["bucket"], name: "index_projects_on_bucket", using: :btree
  add_index "projects", ["slug"], name: "index_projects_on_slug", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "screen_name",                       null: false
    t.string   "name"
    t.string   "profile_image_url"
    t.string   "twitter_id"
    t.string   "location"
    t.boolean  "moderator",         default: false
    t.boolean  "banned",            default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "users", ["screen_name"], name: "index_users_on_screen_name", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
