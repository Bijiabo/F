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

ActiveRecord::Schema.define(version: 20160128102905) do

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

  create_table "flux_images", force: :cascade do |t|
    t.integer  "flux_id"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
  end

  add_index "flux_images", ["flux_id"], name: "index_flux_images_on_flux_id"

  create_table "flux_likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "flux_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "flux_likes", ["flux_id"], name: "index_flux_likes_on_flux_id"
  add_index "flux_likes", ["user_id"], name: "index_flux_likes_on_user_id"

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

  create_table "private_messages", force: :cascade do |t|
    t.integer  "toUser_id"
    t.integer  "fromUser_id"
    t.string   "content"
    t.string   "picture"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "private_messages", ["fromUser_id"], name: "index_private_messages_on_fromUser_id"
  add_index "private_messages", ["toUser_id"], name: "index_private_messages_on_toUser_id"

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

  create_table "remote_notification_tokens", force: :cascade do |t|
    t.string   "token"
    t.integer  "user_id"
    t.integer  "failed_count", default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "remote_notification_tokens", ["token"], name: "index_remote_notification_tokens_on_token"
  add_index "remote_notification_tokens", ["user_id"], name: "index_remote_notification_tokens_on_user_id"

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

  create_table "trends", force: :cascade do |t|
    t.text     "content"
    t.integer  "to_user_id"
    t.integer  "from_user_id"
    t.integer  "to_cat_id"
    t.integer  "from_cat_id"
    t.integer  "flux_id"
    t.string   "trends_type"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "flux_comment_id"
  end

  add_index "trends", ["flux_id"], name: "index_trends_on_flux_id"
  add_index "trends", ["from_cat_id"], name: "index_trends_on_from_cat_id"
  add_index "trends", ["from_user_id"], name: "index_trends_on_from_user_id"
  add_index "trends", ["read"], name: "index_trends_on_read"
  add_index "trends", ["to_cat_id"], name: "index_trends_on_to_cat_id"
  add_index "trends", ["to_user_id"], name: "index_trends_on_to_user_id"
  add_index "trends", ["trends_type"], name: "index_trends_on_trends_type"

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
    t.string   "avatar"
    t.integer  "gender",            default: 0
    t.string   "province"
    t.string   "city"
    t.string   "introduction"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
