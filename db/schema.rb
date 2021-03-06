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

ActiveRecord::Schema.define(version: 20161021181657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aspects", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "convergences", force: :cascade do |t|
    t.integer  "story_id",   null: false
    t.integer  "parent_id",  null: false
    t.integer  "child_id",   null: false
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "families", force: :cascade do |t|
    t.string   "name"
    t.integer  "admin_id"
    t.boolean  "private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "family_admins", force: :cascade do |t|
    t.integer  "family_id"
    t.integer  "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "family_admins", ["admin_id"], name: "index_family_admins_on_admin_id", using: :btree
  add_index "family_admins", ["family_id"], name: "index_family_admins_on_family_id", using: :btree

  create_table "family_aspects", force: :cascade do |t|
    t.integer  "family_id"
    t.integer  "aspect_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "family_aspects", ["aspect_id"], name: "index_family_aspects_on_aspect_id", using: :btree
  add_index "family_aspects", ["family_id"], name: "index_family_aspects_on_family_id", using: :btree

  create_table "family_moderators", force: :cascade do |t|
    t.integer  "family_id"
    t.integer  "moderator_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "family_moderators", ["family_id"], name: "index_family_moderators_on_family_id", using: :btree
  add_index "family_moderators", ["moderator_id"], name: "index_family_moderators_on_moderator_id", using: :btree

  create_table "family_stories", force: :cascade do |t|
    t.integer  "family_id"
    t.integer  "story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "family_stories", ["family_id"], name: "index_family_stories_on_family_id", using: :btree
  add_index "family_stories", ["story_id"], name: "index_family_stories_on_story_id", using: :btree

  create_table "family_users", force: :cascade do |t|
    t.integer  "family_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "family_users", ["family_id"], name: "index_family_users_on_family_id", using: :btree
  add_index "family_users", ["user_id"], name: "index_family_users_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "story_id",   null: false
    t.integer  "parent_id"
    t.string   "title",      null: false
    t.text     "text",       null: false
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pages", ["level"], name: "index_pages_on_level", using: :btree
  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["story_id"], name: "index_pages_on_story_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.string   "title",                      null: false
    t.text     "summary",                    null: false
    t.integer  "user_id",                    null: false
    t.boolean  "published",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "stories", ["published"], name: "index_stories_on_published", using: :btree
  add_index "stories", ["user_id"], name: "index_stories_on_user_id", using: :btree

  create_table "story_aspects", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "aspect_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "story_aspects", ["aspect_id"], name: "index_story_aspects_on_aspect_id", using: :btree
  add_index "story_aspects", ["story_id"], name: "index_story_aspects_on_story_id", using: :btree

  create_table "story_favorites", force: :cascade do |t|
    t.integer  "story_id_id"
    t.integer  "user_id_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "story_favorites", ["story_id_id"], name: "index_story_favorites_on_story_id_id", using: :btree
  add_index "story_favorites", ["user_id_id"], name: "index_story_favorites_on_user_id_id", using: :btree

  create_table "user_favorites", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_favorites", ["followed_id"], name: "index_user_favorites_on_followed_id", using: :btree
  add_index "user_favorites", ["follower_id"], name: "index_user_favorites_on_follower_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
