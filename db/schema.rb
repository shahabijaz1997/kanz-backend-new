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

ActiveRecord::Schema[7.0].define(version: 2023_06_06_092406) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

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

  create_table "admin_roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_role_id"
    t.string "first_name"
    t.string "last_name"
    t.index ["admin_role_id"], name: "index_admin_users_on_admin_role_id"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "attachments", force: :cascade do |t|
    t.string "parent_type"
    t.bigint "parent_id"
    t.string "name"
    t.string "attachment_kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_type", "parent_id"], name: "index_attachments_on_parent"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "states", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investor_profiles", force: :cascade do |t|
    t.string "residence"
    t.string "accreditation", null: false
    t.boolean "accepted_investment_criteria"
    t.bigint "country_id"
    t.bigint "investor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "legal_name"
    t.index ["country_id"], name: "index_investor_profiles_on_country_id"
    t.index ["investor_id"], name: "index_investor_profiles_on_investor_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "step"
    t.integer "index"
    t.string "title"
    t.boolean "required"
    t.integer "question_type", default: 0
    t.string "category"
    t.string "statement"
    t.text "description"
    t.jsonb "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "realtor_profiles", force: :cascade do |t|
    t.integer "no_of_properties"
    t.bigint "nationality_id"
    t.bigint "residence_id"
    t.bigint "realtor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nationality_id"], name: "index_realtor_profiles_on_nationality_id"
    t.index ["realtor_id"], name: "index_realtor_profiles_on_realtor_id"
    t.index ["residence_id"], name: "index_realtor_profiles_on_residence_id"
  end

  create_table "role_vise_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "label"
    t.integer "index"
    t.boolean "required", default: true
    t.string "allowed_file_types", array: true
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_role_vise_attachments_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "startup_profiles", force: :cascade do |t|
    t.string "company_name", null: false
    t.string "legal_name", null: false
    t.string "industry_market", array: true
    t.string "website"
    t.string "address"
    t.string "logo"
    t.text "description"
    t.string "ceo_name"
    t.string "ceo_email"
    t.float "total_capital_raised", null: false
    t.float "current_round_capital_target", null: false
    t.bigint "startup_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_startup_profiles_on_country_id"
    t.index ["startup_id"], name: "index_startup_profiles_on_startup_id"
  end

  create_table "syndicate_profiles", force: :cascade do |t|
    t.string "name"
    t.string "tagline"
    t.boolean "have_you_ever_raised"
    t.float "raised_amount"
    t.integer "no_times_raised"
    t.string "industry_market", default: [], array: true
    t.string "region", array: true
    t.string "profile_link"
    t.string "dealflow"
    t.string "logo"
    t.integer "syndicate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "jti", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.jsonb "meta_info", default: {}
    t.string "type"
    t.integer "status", default: 0
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.bigint "role_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "users_responses", force: :cascade do |t|
    t.integer "question_id"
    t.text "answers", default: [], array: true
    t.jsonb "answer_meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["question_id", "user_id"], name: "index_users_responses_on_question_id_and_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_users", "admin_roles"
end
