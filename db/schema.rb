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

ActiveRecord::Schema.define(version: 20160109175708) do

  create_table "cats", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "breed"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "user_id"
    t.decimal  "latitude",   precision: 15, scale: 13
    t.decimal  "longitude",  precision: 15, scale: 13
  end

  add_index "cats", ["user_id"], name: "index_cats_on_user_id"

  create_table "flux_comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "flux_comments_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "childComment_id"
    t.integer  "parentComment_id"
    t.integer  "flux_id"
  end

  add_index "flux_comments", ["flux_comments_id"], name: "index_flux_comments_on_flux_comments_id"
  add_index "flux_comments", ["flux_id"], name: "index_flux_comments_on_flux_id"
  add_index "flux_comments", ["user_id", "flux_comments_id"], name: "index_flux_comments_on_user_id_and_flux_comments_id"
  add_index "flux_comments", ["user_id"], name: "index_flux_comments_on_user_id"

  create_table "fluxes", force: :cascade do |t|
    t.string   "motion"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "picture"
    t.integer  "like_count",    default: 0
    t.integer  "comment_count", default: 0
  end

  add_index "fluxes", ["user_id", "created_at"], name: "index_fluxes_on_user_id_and_created_at"
  add_index "fluxes", ["user_id"], name: "index_fluxes_on_user_id"

  create_table "readers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "tokens", force: :cascade do |t|
    t.string   "token"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "deviceID"
  end

  add_index "tokens", ["token"], name: "index_tokens_on_token"
  add_index "tokens", ["user_id"], name: "index_tokens_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
