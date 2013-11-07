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

ActiveRecord::Schema.define(version: 20131106150125) do

  create_table "app_runtime_histories", force: true do |t|
    t.integer  "app_id"
    t.string   "type"
    t.integer  "runtime"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "app_runtime_histories", ["app_id"], name: "index_app_runtime_histories_on_app_id"
  add_index "app_runtime_histories", ["user_id"], name: "index_app_runtime_histories_on_user_id"

  create_table "apps", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "post_id"
    t.text     "comment"
    t.boolean  "enabled"
    t.boolean  "blocked"
    t.integer  "warning"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "events", force: true do |t|
    t.integer  "app_id"
    t.string   "content"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["app_id"], name: "index_events_on_app_id"

  create_table "game_rankings", force: true do |t|
    t.integer  "app_id"
    t.string   "type"
    t.integer  "ranking"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_rankings", ["app_id"], name: "index_game_rankings_on_app_id"

  create_table "posts", force: true do |t|
    t.integer  "app_id"
    t.string   "type"
    t.text     "content"
    t.boolean  "enabled"
    t.boolean  "blocked"
    t.integer  "warning"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["app_id"], name: "index_posts_on_app_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "app_id"
    t.float    "stars"
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["app_id"], name: "index_ratings_on_app_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "user_game_rankings", force: true do |t|
    t.integer  "app_id"
    t.integer  "user_id"
    t.string   "ranking"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_game_rankings", ["app_id"], name: "index_user_game_rankings_on_app_id"
  add_index "user_game_rankings", ["user_id"], name: "index_user_game_rankings_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name",                                null: false
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token",   default: "",   null: false
    t.string   "uuid",                   default: "",   null: false
    t.string   "phone",                  default: "",   null: false
    t.string   "ranking"
    t.integer  "points"
    t.integer  "cash",                   default: 0,    null: false
    t.boolean  "sex"
    t.date     "birthday"
    t.string   "city",                   default: ""
    t.string   "intro",                  default: ""
    t.string   "sns",                    default: "", null: false
    t.text     "setting"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end