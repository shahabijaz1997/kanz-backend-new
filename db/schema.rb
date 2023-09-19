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

ActiveRecord::Schema[7.0].define(version: 2023_09_19_082331) do
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
    t.boolean "deactivated"
    t.index ["admin_role_id"], name: "index_admin_users_on_admin_role_id"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "attachment_configs", force: :cascade do |t|
    t.string "name", null: false
    t.string "label"
    t.integer "index"
    t.boolean "required", default: true
    t.string "allowed_file_types", array: true
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_ar"
    t.string "label_ar"
    t.index ["role_id"], name: "index_attachment_configs_on_role_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "parent_type"
    t.bigint "parent_id"
    t.string "name"
    t.string "attachment_kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "attachment_config_id"
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
    t.string "name_ar"
  end

  create_table "deals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "target"
    t.integer "deal_type", default: 0
    t.integer "status", default: 0
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "submitted_at"
    t.bigint "author_id", null: false
    t.integer "success_benchmark"
    t.float "how_much_funded"
    t.boolean "agreed_with_kanz_terms", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_deals_on_author_id"
  end

  create_table "features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "title_ar"
    t.text "description"
    t.text "description_ar"
    t.bigint "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_features_on_deal_id"
  end

  create_table "funding_rounds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "round", default: 0
    t.integer "instrument_type", default: 0
    t.integer "instrument_sub_type", default: 0
    t.integer "valuation_phase", default: 0
    t.decimal "valuation"
    t.bigint "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_funding_rounds_on_deal_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_ar", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investor_profiles", force: :cascade do |t|
    t.boolean "accepted_investment_criteria"
    t.bigint "country_id"
    t.bigint "investor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "legal_name"
    t.bigint "residence_id"
    t.bigint "accreditation_option_id"
    t.index ["accreditation_option_id"], name: "index_investor_profiles_on_accreditation_option_id"
    t.index ["country_id"], name: "index_investor_profiles_on_country_id"
    t.index ["investor_id"], name: "index_investor_profiles_on_investor_id"
    t.index ["residence_id"], name: "index_investor_profiles_on_residence_id"
  end

  create_table "notification_templates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
  end

  create_table "options", force: :cascade do |t|
    t.string "statement"
    t.string "statement_ar"
    t.integer "index", default: 1
    t.string "unit", default: "Million"
    t.string "currency", default: "USD"
    t.boolean "is_range"
    t.float "lower_limit"
    t.float "uper_limit"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.string "label_ar"
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "profiles_industries", force: :cascade do |t|
    t.string "profile_type"
    t.bigint "profile_id"
    t.bigint "industry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id"], name: "index_profiles_industries_on_industry_id"
    t.index ["profile_type", "profile_id"], name: "index_profiles_industries_on_profile"
  end

  create_table "profiles_regions", force: :cascade do |t|
    t.string "profile_type"
    t.bigint "profile_id"
    t.bigint "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_type", "profile_id"], name: "index_profiles_regions_on_profile"
    t.index ["region_id"], name: "index_profiles_regions_on_region_id"
  end

  create_table "property_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "country_id"
    t.string "state"
    t.string "city"
    t.string "area"
    t.string "location"
    t.string "building_name"
    t.string "street_address"
    t.integer "size_unit", default: 0
    t.float "size"
    t.boolean "has_bedrooms"
    t.integer "no_bedrooms"
    t.boolean "has_kitchen"
    t.integer "no_kitchen"
    t.boolean "has_washroom"
    t.integer "no_washrooms"
    t.boolean "has_parking"
    t.integer "parking_capacity"
    t.boolean "has_swimming_pool"
    t.integer "swimming_pool_type", default: 0
    t.boolean "is_rental"
    t.integer "rental_period", default: 0
    t.decimal "rental_amount"
    t.float "dividend_yeild"
    t.float "yearly_appreciation"
    t.jsonb "external_links", default: {}
    t.bigint "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_property_details_on_country_id"
    t.index ["deal_id"], name: "index_property_details_on_deal_id"
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
    t.string "title_ar"
    t.string "statement_ar"
    t.string "category_ar"
    t.text "description_ar"
    t.integer "kind", default: 0
    t.jsonb "suggestions", default: {}
  end

  create_table "questions_sections", id: false, force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "section_id", null: false
    t.index ["question_id", "section_id"], name: "index_questions_sections_on_question_id_and_section_id"
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

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_ar", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title_ar"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "index"
    t.string "title", limit: 50
    t.string "title_ar", limit: 50
    t.string "description"
    t.string "description_ar"
    t.boolean "is_multiple"
    t.string "button_label", limit: 50
    t.string "button_label_ar", limit: 50
    t.bigint "stepper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stepper_id"], name: "index_sections_on_stepper_id"
  end

  create_table "startup_profiles", force: :cascade do |t|
    t.string "company_name", null: false
    t.string "legal_name", null: false
    t.string "industry_market", array: true
    t.string "website"
    t.string "address"
    t.text "description"
    t.string "ceo_name"
    t.string "ceo_email"
    t.float "total_capital_raised"
    t.float "current_round_capital_target"
    t.bigint "startup_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "currency", default: "USD", null: false
    t.index ["country_id"], name: "index_startup_profiles_on_country_id"
    t.index ["startup_id"], name: "index_startup_profiles_on_startup_id"
  end

  create_table "steppers", force: :cascade do |t|
    t.integer "index"
    t.integer "stepper_type", default: 0
    t.string "title", limit: 100
    t.string "title_ar", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "syndicate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "statement"
    t.string "statement_ar"
    t.boolean "enabled"
    t.decimal "value"
    t.bigint "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_terms_on_deal_id"
  end

  create_table "unique_selling_points", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.jsonb "profile_states", default: {}
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
    t.string "provider"
    t.string "uid"
    t.string "language", limit: 5, default: "en"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "users_responses", force: :cascade do |t|
    t.integer "question_id"
    t.text "answer", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.bigint "selected_option_ids", default: [], array: true
    t.index ["question_id", "user_id"], name: "index_users_responses_on_question_id_and_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_users", "admin_roles"
  add_foreign_key "deals", "users", column: "author_id"
end
