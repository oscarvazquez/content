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

ActiveRecord::Schema.define(version: 20160404015232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "role",            default: "member"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["business_id"], name: "index_admins_on_business_id", using: :btree

  create_table "business_categories", force: true do |t|
    t.integer  "category_id"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "business_categories", ["business_id"], name: "index_business_categories_on_business_id", using: :btree
  add_index "business_categories", ["category_id"], name: "index_business_categories_on_category_id", using: :btree

  create_table "business_subcategories", force: true do |t|
    t.integer  "subcategory_id"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "business_subcategories", ["business_id"], name: "index_business_subcategories_on_business_id", using: :btree
  add_index "business_subcategories", ["subcategory_id"], name: "index_business_subcategories_on_subcategory_id", using: :btree

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "login"
    t.string   "street_address"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "location"
    t.string   "facebook"
    t.string   "linked_in"
    t.string   "google"
    t.string   "twitter"
    t.string   "website"
    t.string   "profile_pic"
    t.text     "description"
    t.boolean  "pitch",              default: true
    t.boolean  "status",             default: true
    t.boolean  "confirmation_email", default: false
    t.string   "email_token"
    t.float    "rating",             default: 0.0
    t.integer  "rating_count",       default: 0
    t.float    "lat"
    t.float    "decimal"
    t.float    "lng"
    t.integer  "inquiries",          default: 0
    t.integer  "jobs_completed",     default: 0
    t.string   "excerpt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "commenter_id"
    t.string   "commenter_type"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["commenter_id", "commenter_type"], name: "index_comments_on_commenter_id_and_commenter_type", using: :btree

  create_table "follow_requests", force: true do |t|
    t.integer  "follower_id"
    t.string   "follower_type"
    t.integer  "followed_id"
    t.string   "followed_type"
    t.string   "message"
    t.boolean  "status",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follow_requests", ["followed_id", "followed_type"], name: "index_follow_requests_on_followed_id_and_followed_type", using: :btree
  add_index "follow_requests", ["follower_id", "follower_type"], name: "index_follow_requests_on_follower_id_and_follower_type", using: :btree

  create_table "followers", force: true do |t|
    t.integer  "follower_id"
    t.string   "follower_type"
    t.integer  "followed_id"
    t.string   "followed_type"
    t.boolean  "status",        default: true
    t.string   "relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followers", ["followed_id", "followed_type"], name: "index_followers_on_followed_id_and_followed_type", using: :btree
  add_index "followers", ["follower_id", "follower_type"], name: "index_followers_on_follower_id_and_follower_type", using: :btree

  create_table "jobs", force: true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.integer  "timeline"
    t.float    "price"
    t.string   "title"
    t.string   "body"
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "length"
    t.boolean  "completed",        default: false
    t.integer  "status",           default: 0
    t.integer  "time_completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["business_id"], name: "index_jobs_on_business_id", using: :btree
  add_index "jobs", ["category_id"], name: "index_jobs_on_category_id", using: :btree
  add_index "jobs", ["subcategory_id"], name: "index_jobs_on_subcategory_id", using: :btree
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.integer  "liker_id"
    t.string   "liker_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "index_likes_on_likeable_id_and_likeable_type", using: :btree
  add_index "likes", ["liker_id", "liker_type"], name: "index_likes_on_liker_id_and_liker_type", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.text     "message"
    t.boolean  "status",        default: false
    t.integer  "sender_id"
    t.string   "sender_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["receiver_id", "receiver_type"], name: "index_messages_on_receiver_id_and_receiver_type", using: :btree
  add_index "messages", ["sender_id", "sender_type"], name: "index_messages_on_sender_id_and_sender_type", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "event_id"
    t.string   "event_type"
    t.integer  "initiator_id"
    t.string   "initiator_type"
    t.string   "notification"
    t.boolean  "status",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["event_id", "event_type"], name: "index_notifications_on_event_id_and_event_type", using: :btree
  add_index "notifications", ["initiator_id", "initiator_type"], name: "index_notifications_on_initiator_id_and_initiator_type", using: :btree
  add_index "notifications", ["receiver_id", "receiver_type"], name: "index_notifications_on_receiver_id_and_receiver_type", using: :btree

  create_table "pitches", force: true do |t|
    t.text     "pitch"
    t.string   "title"
    t.integer  "user_id"
    t.integer  "business_id"
    t.integer  "length"
    t.float    "price",       default: 0.0
    t.string   "timeline"
    t.boolean  "read",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pitches", ["business_id"], name: "index_pitches_on_business_id", using: :btree
  add_index "pitches", ["user_id"], name: "index_pitches_on_user_id", using: :btree

  create_table "requests", force: true do |t|
    t.integer  "business_id"
    t.integer  "category_id"
    t.text     "description"
    t.integer  "length"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requests", ["business_id"], name: "index_requests_on_business_id", using: :btree
  add_index "requests", ["category_id"], name: "index_requests_on_category_id", using: :btree

  create_table "reviews", force: true do |t|
    t.text     "review"
    t.integer  "rating"
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "writer_id"
    t.string   "writer_type"
    t.integer  "job_id"
    t.boolean  "anonymous",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["job_id"], name: "index_reviews_on_job_id", using: :btree
  add_index "reviews", ["receiver_id", "receiver_type"], name: "index_reviews_on_receiver_id_and_receiver_type", using: :btree
  add_index "reviews", ["writer_id", "writer_type"], name: "index_reviews_on_writer_id_and_writer_type", using: :btree

  create_table "subcategories", force: true do |t|
    t.string   "sub"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id", using: :btree

  create_table "user_categories", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_categories", ["category_id"], name: "index_user_categories_on_category_id", using: :btree
  add_index "user_categories", ["user_id"], name: "index_user_categories_on_user_id", using: :btree

  create_table "user_subcategories", force: true do |t|
    t.integer  "user_id"
    t.integer  "subcategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_subcategories", ["subcategory_id"], name: "index_user_subcategories_on_subcategory_id", using: :btree
  add_index "user_subcategories", ["user_id"], name: "index_user_subcategories_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "login"
    t.string   "user_token"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "confirmation_email", default: false
    t.string   "email_token"
    t.boolean  "set_current",        default: false
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "location"
    t.string   "zip_code"
    t.float    "lat"
    t.float    "decimal"
    t.float    "lng"
    t.text     "summary"
    t.text     "excerpt"
    t.boolean  "has_resume",         default: false
    t.string   "resume"
    t.string   "profile_pic"
    t.string   "linked_in"
    t.string   "facebook"
    t.string   "google"
    t.string   "website"
    t.string   "twitter"
    t.boolean  "status",             default: true
    t.float    "rating",             default: 0.0
    t.integer  "rating_count",       default: 0
    t.integer  "response_time",      default: 0
    t.integer  "inquiries",          default: 0
    t.integer  "jobs_completed",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", force: true do |t|
    t.string   "type"
    t.string   "link"
    t.string   "upload_link"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "excerpt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "works", ["category_id"], name: "index_works_on_category_id", using: :btree
  add_index "works", ["user_id"], name: "index_works_on_user_id", using: :btree

end
