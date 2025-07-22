# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_07_22_033144) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "start"
    t.string "end"
    t.string "distance"
    t.string "duration"
    t.integer "steps"
    t.bigint "user_id", null: false
    t.datetime "walked_at"
    t.index ["user_id"], name: "index_destinations_on_user_id"
  end

  create_table "monster_species", force: :cascade do |t|
    t.string "name_stage_1"
    t.string "name_stage_2"
    t.string "name_stage_3"
    t.text "description"
    t.string "image_1"
    t.string "image_2"
    t.string "image_3"
    t.integer "evolution_level_1"
    t.integer "evolution_level_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "post_image"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "user_monsters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "monster_species_id", null: false
    t.integer "level", default: 1, null: false
    t.integer "experience", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monster_species_id"], name: "index_user_monsters_on_monster_species_id"
    t.index ["user_id"], name: "index_user_monsters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "", null: false
    t.string "avatar"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "destinations", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "user_monsters", "monster_species", column: "monster_species_id"
  add_foreign_key "user_monsters", "users"
end
