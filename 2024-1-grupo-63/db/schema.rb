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

ActiveRecord::Schema[7.1].define(version: 2024_06_12_211823) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "actividad_messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "chat_room_actividad_id"
    t.index ["chat_room_actividad_id"], name: "index_actividad_messages_on_chat_room_actividad_id"
    t.index ["user_id"], name: "index_actividad_messages_on_user_id"
  end

  create_table "actividads", force: :cascade do |t|
    t.string "titulo"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "archivado", default: false
    t.integer "valor", default: 0, null: false
    t.index ["user_id"], name: "index_actividads_on_user_id"
  end

  create_table "additional_tables", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "pronouns"
    t.string "username"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture", default: "/assets/images/predeterminada.jpg"
    t.string "big_picture", default: "/assets/images/predeterminada.jpg"
    t.string "biografia", default: "Cuentanos sobre ti"
    t.index ["user_id"], name: "index_additional_tables_on_user_id"
  end

  create_table "chat_room_actividads", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "actividad_id"
    t.bigint "user_id"
    t.index ["actividad_id"], name: "index_chat_room_actividads_on_actividad_id"
    t.index ["user_id"], name: "index_chat_room_actividads_on_user_id"
  end

  create_table "chat_room_users", force: :cascade do |t|
    t.bigint "chat_room_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_chat_room_users_on_chat_room_id"
    t.index ["user_id"], name: "index_chat_room_users_on_user_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follow_requests", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follow_requests_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_follow_requests_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_follow_requests_on_follower_id"
  end

  create_table "followers", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_followers_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_followers_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_followers_on_follower_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "actividad_id", null: false
    t.bigint "user_id", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actividad_id"], name: "index_memberships_on_actividad_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "chat_room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "resenas", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "actividad_id", null: false
    t.string "contenido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "calificacion"
    t.index ["actividad_id"], name: "index_resenas_on_actividad_id"
    t.index ["user_id"], name: "index_resenas_on_user_id"
  end

  create_table "solicituds", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "actividad_id"
    t.string "message"
    t.string "status"
    t.boolean "pending", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actividad_id"], name: "index_solicituds_on_actividad_id"
    t.index ["user_id"], name: "index_solicituds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "global_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "actividads", "users"
  add_foreign_key "additional_tables", "users"
  add_foreign_key "chat_room_users", "chat_rooms"
  add_foreign_key "chat_room_users", "users"
  add_foreign_key "followers", "users", column: "followed_id"
  add_foreign_key "followers", "users", column: "follower_id"
  add_foreign_key "memberships", "actividads"
  add_foreign_key "memberships", "users"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "resenas", "actividads"
  add_foreign_key "resenas", "users"
  add_foreign_key "solicituds", "actividads"
  add_foreign_key "solicituds", "users"
end
