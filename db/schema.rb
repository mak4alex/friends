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

ActiveRecord::Schema.define(version: 20171112200050) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "vk_comment_id"
    t.integer "vk_post_id"
    t.integer "vk_user_id"
    t.text "body"
    t.integer "likes_count"
    t.integer "site_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vk_comment_id", "vk_user_id", "vk_post_id"], name: "index_comments_on_vk_comment_id_and_vk_user_id_and_vk_post_id", unique: true
  end

  create_table "links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "vk_user_id"
    t.integer "vk_object_id"
    t.string "linkable_type", limit: 16
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vk_user_id", "vk_object_id", "linkable_type"], name: "index_links_on_vk_user_id_and_vk_object_id_and_linkable_type", unique: true
  end

  create_table "online_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "vk_user_id"
    t.integer "platform", limit: 1
    t.datetime "last_seen", null: false
    t.boolean "online"
    t.boolean "online_mobile"
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "vk_post_id"
    t.integer "owner_id"
    t.integer "from_id"
    t.datetime "site_created_at"
    t.text "body"
    t.string "post_kind", limit: 16
    t.integer "likes_count"
    t.integer "reposts_count"
    t.integer "comments_count"
    t.integer "views_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vk_post_id", "owner_id", "from_id"], name: "index_posts_on_vk_post_id_and_owner_id_and_from_id", unique: true
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "status"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delay"
    t.string "mode_type"
    t.integer "cycle_count"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer "vk_user_id"
    t.string "first_name"
    t.string "last_name"
    t.integer "sex", limit: 1
    t.string "domain"
    t.string "screen_name"
    t.string "photo_50"
    t.string "photo_100"
    t.string "photo_400_orig"
    t.string "status", limit: 250
    t.boolean "hidden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about"
    t.string "birthday"
    t.boolean "can_see_all_posts"
    t.boolean "can_comment_on_wall"
    t.string "deactivated"
    t.index ["vk_user_id"], name: "index_users_on_vk_user_id", unique: true
  end

end
