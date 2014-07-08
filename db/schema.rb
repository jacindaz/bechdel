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

ActiveRecord::Schema.define(version: 20140708220933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actresses", force: true do |t|
    t.string   "name",       null: false
    t.integer  "movies_id",  null: false
    t.string   "gender",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actresses_movies", force: true do |t|
    t.integer  "movie_id",   null: false
    t.integer  "actress_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "parent_comment_id"
    t.integer  "movie_id",          null: false
    t.integer  "user_id",           null: false
    t.text     "body",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: true do |t|
    t.string   "title",                                        null: false
    t.integer  "year",                                         null: false
    t.text     "summary",                                      null: false
    t.string   "language",                                     null: false
    t.string   "country_produced",                             null: false
    t.string   "bechdel_rating",         default: "no rating", null: false
    t.text     "poster_url",                                   null: false
    t.string   "rotten_tomatoes_rating"
    t.string   "movie_url",                                    null: false
    t.integer  "user_id",                                      null: false
    t.integer  "actresses_id",                                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movies", ["title"], name: "index_movies_on_title", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username",   null: false
    t.string   "password"
    t.string   "avatar_url"
    t.string   "provider"
    t.string   "location"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username", "email"], name: "index_users_on_username_and_email", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "movie_id",   null: false
    t.integer  "user_id",    null: false
    t.integer  "vote",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
