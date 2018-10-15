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

ActiveRecord::Schema.define(version: 20170922142935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "postgres_fdw"
  enable_extension "plpgsql"

  create_table "account_snapshots", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "youtube_account_id"
    t.integer  "instagram_account_id"
    t.bigint   "youtube_channel_view_count"
    t.integer  "youtube_channel_comment_count"
    t.integer  "youtube_channel_video_count"
    t.integer  "youtube_channel_subscriber_count"
    t.integer  "fluenza_views_count"
    t.integer  "ig_follows"
    t.bigint   "ig_overall_likes"
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "type"
    t.string   "youtube_channel_id"
    t.string   "youtube_channel_title"
    t.string   "youtube_channel_description"
    t.boolean  "youtube_channel_public"
    t.boolean  "youtube_channel_unlisted"
    t.bigint   "youtube_channel_view_count"
    t.bigint   "youtube_channel_comment_count"
    t.integer  "youtube_channel_video_count"
    t.bigint   "youtube_channel_subscriber_count"
    t.boolean  "youtube_channel_subscriber_count_visible"
    t.string   "youtube_channel_thumbnail"
    t.string   "youtube_authorization_token"
    t.string   "instagram_authorization_token"
    t.string   "instagram_access_token"
    t.bigint   "fluenza_views_count",                      default: 0
    t.string   "youtube_channel_handler"
    t.integer  "influencer_id"
    t.datetime "latest_snapshot_date"
    t.string   "slug"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category"
    t.string   "ig_username"
    t.string   "ig_profile_picture"
    t.integer  "ig_follows"
    t.string   "ig_followed_by"
    t.string   "ig_full_name"
    t.string   "ig_website"
    t.string   "ig_media"
    t.string   "ig_id"
    t.boolean  "data_loaded",                              default: false
    t.bigint   "ig_overall_likes"
    t.index ["youtube_channel_subscriber_count"], name: "index_accounts_on_youtube_channel_subscriber_count", using: :btree
  end

  create_table "agencies", force: :cascade do |t|
    t.string   "name"
    t.string   "manager_name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_agencies_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_agencies_on_reset_password_token", unique: true, using: :btree
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "budget"
    t.string   "comments"
    t.string   "briefing"
    t.string   "backlinks"
  end

  create_table "followings", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "influencer_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "influencers", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "platform"
    t.string   "title"
    t.string   "description"
    t.string   "slug"
    t.float    "score"
  end

  create_table "post_snapshots", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "post_id"
    t.integer  "like_count"
    t.integer  "comment_count"
    t.string   "description"
    t.index ["post_id"], name: "index_post_snapshots_on_post_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "instagram_account_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "like_count"
    t.string   "instagram_id"
    t.integer  "comment_count"
    t.string   "description"
    t.string   "standard_res_image"
    t.string   "ig_code"
    t.datetime "published_at"
    t.index ["instagram_id"], name: "index_posts_on_instagram_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "user_campaigns", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_media_contents", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "post_id"
    t.integer  "video_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "budget"
    t.string   "annotations"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "youtube_auth_token"
    t.string   "instagram_auth_token"
    t.string   "access_token"
    t.integer  "agency_id"
    t.string   "name"
    t.index ["access_token"], name: "index_users_on_access_token", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "video_snapshots", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "video_id"
    t.integer  "view_count"
    t.integer  "comment_count"
    t.integer  "like_count"
    t.integer  "dislike_count"
    t.integer  "favorite_count"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "youtube_id"
    t.integer  "youtube_account_id"
    t.integer  "view_count"
    t.integer  "comment_count"
    t.integer  "like_count"
    t.integer  "dislike_count"
    t.integer  "favorite_count"
    t.datetime "last_time_fetched"
    t.boolean  "promoted_content"
    t.string   "description"
    t.integer  "category_id"
    t.datetime "published_at"
  end

end
