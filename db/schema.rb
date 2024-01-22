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

ActiveRecord::Schema[7.0].define(version: 2024_01_18_075317) do
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
    t.string "first_name"
    t.string "last_name"
    t.bigint "admin_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "configurable_id"
    t.string "configurable_type", default: "AttachmentConfig"
    t.string "uploaded_by_type"
    t.bigint "uploaded_by_id"
    t.index ["parent_type", "parent_id"], name: "index_attachments_on_parent"
    t.index ["uploaded_by_type", "uploaded_by_id"], name: "index_attachments_on_uploaded_by"
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

  create_table "comments", force: :cascade do |t|
    t.text "message"
    t.bigint "author_id", null: false
    t.bigint "thread_id"
    t.bigint "deal_id", null: false
    t.integer "state", default: 0
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["deal_id"], name: "index_comments_on_deal_id"
    t.index ["recipient_id"], name: "index_comments_on_recipient_id"
    t.index ["thread_id"], name: "index_comments_on_thread_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "states", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_ar"
  end

  create_table "deals", force: :cascade do |t|
    t.bigint "target"
    t.integer "deal_type", default: 0
    t.integer "status", default: 0
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "submitted_at"
    t.bigint "user_id", null: false
    t.integer "success_benchmark"
    t.float "how_much_funded"
    t.boolean "agreed_with_kanz_terms", default: false
    t.string "title"
    t.text "description"
    t.uuid "token", default: -> { "gen_random_uuid()" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "current_state", default: {}
    t.integer "model", default: 0
    t.bigint "syndicate_id"
    t.datetime "closing_date"
    t.index ["syndicate_id"], name: "index_deals_on_syndicate_id"
    t.index ["user_id"], name: "index_deals_on_user_id"
  end

  create_table "dependency_trees", force: :cascade do |t|
    t.integer "condition", default: 0
    t.string "value"
    t.string "dependable_type", null: false
    t.bigint "dependable_id", null: false
    t.string "dependent_type", null: false
    t.bigint "dependent_id", null: false
    t.integer "operation", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dependable_type", "dependable_id"], name: "index_dependency_trees_on_dependable"
    t.index ["dependent_type", "dependent_id"], name: "index_dependency_trees_on_dependent"
  end

  create_table "external_links", force: :cascade do |t|
    t.string "url"
    t.integer "index"
    t.bigint "deal_id"
    t.bigint "field_attribute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_external_links_on_deal_id"
    t.index ["field_attribute_id"], name: "index_external_links_on_field_attribute_id"
  end

  create_table "features", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "deal_id"
    t.bigint "field_attribute_id"
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_features_on_deal_id"
    t.index ["field_attribute_id"], name: "index_features_on_field_attribute_id"
  end

  create_table "field_attributes", force: :cascade do |t|
    t.integer "index", default: 0
    t.string "statement"
    t.string "statement_ar"
    t.string "label"
    t.string "label_ar"
    t.text "description"
    t.text "description_ar"
    t.boolean "is_required", default: false
    t.integer "field_type", default: 0
    t.string "permitted_types", array: true
    t.jsonb "size_constraints", default: {}
    t.float "suggestions", default: [], array: true
    t.string "field_mapping"
    t.bigint "dependent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "input_type", default: 0
    t.bigint "section_id"
  end

  create_table "fund_raiser_profiles", force: :cascade do |t|
    t.string "company_name"
    t.string "legal_name"
    t.string "industry_market", array: true
    t.string "website"
    t.string "address"
    t.text "description"
    t.string "ceo_name"
    t.string "ceo_email"
    t.float "total_capital_raised"
    t.float "current_round_capital_target"
    t.bigint "fund_raiser_id"
    t.bigint "residence_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "currency", default: "USD", null: false
    t.bigint "nationality_id"
    t.integer "no_of_properties"
    t.index ["fund_raiser_id"], name: "index_fund_raiser_profiles_on_fund_raiser_id"
    t.index ["residence_id"], name: "index_fund_raiser_profiles_on_residence_id"
  end

  create_table "funding_rounds", force: :cascade do |t|
    t.bigint "round_id", default: 0
    t.bigint "instrument_type_id", default: 0
    t.bigint "safe_type_id", default: 0
    t.bigint "equity_type_id", default: 0
    t.bigint "valuation_phase_id", default: 0
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

  create_table "investments", force: :cascade do |t|
    t.decimal "amount", null: false
    t.bigint "deal_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_investments_on_deal_id"
    t.index ["user_id"], name: "index_investments_on_user_id"
  end

  create_table "investor_profiles", force: :cascade do |t|
    t.boolean "accepted_investment_criteria", default: false
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

  create_table "invites", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "expire_at"
    t.bigint "invitee_id", null: false
    t.string "eventable_type"
    t.bigint "eventable_id"
    t.string "message"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "purpose", default: 0
    t.integer "discovery_method", default: 0
    t.index ["eventable_type", "eventable_id"], name: "index_invites_on_eventable"
    t.index ["invitee_id"], name: "index_invites_on_invitee_id"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "statement"
    t.string "statement_ar"
    t.integer "index", default: 1
    t.string "unit", default: "Million"
    t.string "currency", default: "USD"
    t.boolean "is_range", default: false
    t.float "lower_limit"
    t.float "uper_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.string "label_ar"
    t.bigint "optionable_id"
    t.string "optionable_type"
    t.index ["optionable_type", "optionable_id"], name: "index_options_on_optionable_type_and_optionable_id"
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
    t.bigint "country_id"
    t.string "state"
    t.string "city"
    t.string "area"
    t.string "location"
    t.string "building_name"
    t.string "street_address"
    t.integer "size_unit", default: 0
    t.float "size"
    t.boolean "has_bedrooms", default: false
    t.integer "no_bedrooms"
    t.boolean "has_kitchen", default: false
    t.integer "no_kitchen"
    t.boolean "has_washroom", default: false
    t.integer "no_washrooms"
    t.boolean "has_parking", default: false
    t.integer "parking_capacity"
    t.boolean "has_swimming_pool", default: false
    t.bigint "swimming_pool_id", default: 0
    t.boolean "is_rental", default: false
    t.bigint "rental_period_id", default: 0
    t.decimal "rental_amount"
    t.float "dividend_yield"
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
    t.integer "index", default: 0
    t.string "title", limit: 50
    t.string "title_ar", limit: 50
    t.string "description"
    t.string "description_ar"
    t.boolean "is_multiple", default: false
    t.string "add_more_label", limit: 50
    t.string "add_more_label_ar", limit: 50
    t.bigint "stepper_id"
    t.boolean "display_card", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "condition", default: ""
    t.index ["stepper_id"], name: "index_sections_on_stepper_id"
  end

  create_table "spvs", force: :cascade do |t|
    t.string "legal_name", null: false
    t.date "date_of_incorporation", null: false
    t.string "place_of_incorporation", null: false
    t.bigint "registration_certificate_id"
    t.string "legal_structure"
    t.string "jurisdiction"
    t.string "registered_office_address"
    t.jsonb "directors", default: {}
    t.bigint "governance_structure_id"
    t.string "management_agreements", default: "None, as management is internal."
    t.string "parent_company", default: "Not applicable, independent entity."
    t.string "investment_nature"
    t.bigint "investment_strategy_id"
    t.decimal "capital_raised"
    t.decimal "investment_thresholds"
    t.bigint "valuation_report_id"
    t.text "terms"
    t.bigint "aml_kyc_document_id"
    t.bigint "dfsa_compliance_regulations_id"
    t.text "risk_disclosures"
    t.bigint "data_protection_compliance_id"
    t.string "bank_name"
    t.string "branch_name"
    t.string "account_no"
    t.string "account_title"
    t.text "capital_requirements"
    t.bigint "audited_financial_statements_id"
    t.bigint "financial_projections_id"
    t.bigint "financial_reporting_id"
    t.bigint "investor_reporting_id"
    t.bigint "performance_metrics_id"
    t.bigint "shareholder_agreements_id"
    t.bigint "property_deeds_id"
    t.bigint "loan_agreement_id"
    t.bigint "service_provider_contracts_id"
    t.bigint "business_plan_id"
    t.bigint "service_providers_id"
    t.bigint "insurance_policies_id"
    t.text "exit_options"
    t.bigint "divestment_process_id"
    t.bigint "communication_channels_id"
    t.text "investor_queries"
    t.bigint "created_by_id"
    t.integer "status", default: 0
    t.bigint "deal_id"
    t.integer "closing_model", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aml_kyc_document_id"], name: "index_spvs_on_aml_kyc_document_id"
    t.index ["audited_financial_statements_id"], name: "index_spvs_on_audited_financial_statements_id"
    t.index ["business_plan_id"], name: "index_spvs_on_business_plan_id"
    t.index ["communication_channels_id"], name: "index_spvs_on_communication_channels_id"
    t.index ["data_protection_compliance_id"], name: "index_spvs_on_data_protection_compliance_id"
    t.index ["dfsa_compliance_regulations_id"], name: "index_spvs_on_dfsa_compliance_regulations_id"
    t.index ["divestment_process_id"], name: "index_spvs_on_divestment_process_id"
    t.index ["financial_projections_id"], name: "index_spvs_on_financial_projections_id"
    t.index ["financial_reporting_id"], name: "index_spvs_on_financial_reporting_id"
    t.index ["governance_structure_id"], name: "index_spvs_on_governance_structure_id"
    t.index ["insurance_policies_id"], name: "index_spvs_on_insurance_policies_id"
    t.index ["investment_strategy_id"], name: "index_spvs_on_investment_strategy_id"
    t.index ["investor_reporting_id"], name: "index_spvs_on_investor_reporting_id"
    t.index ["loan_agreement_id"], name: "index_spvs_on_loan_agreement_id"
    t.index ["performance_metrics_id"], name: "index_spvs_on_performance_metrics_id"
    t.index ["property_deeds_id"], name: "index_spvs_on_property_deeds_id"
    t.index ["registration_certificate_id"], name: "index_spvs_on_registration_certificate_id"
    t.index ["service_provider_contracts_id"], name: "index_spvs_on_service_provider_contracts_id"
    t.index ["service_providers_id"], name: "index_spvs_on_service_providers_id"
    t.index ["shareholder_agreements_id"], name: "index_spvs_on_shareholder_agreements_id"
    t.index ["valuation_report_id"], name: "index_spvs_on_valuation_report_id"
  end

  create_table "steppers", force: :cascade do |t|
    t.integer "index"
    t.integer "stepper_type", default: 0
    t.string "title", limit: 100
    t.string "title_ar", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "syndicate_groups", force: :cascade do |t|
    t.string "title"
    t.bigint "syndicate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["syndicate_id"], name: "index_syndicate_groups_on_syndicate_id"
  end

  create_table "syndicate_members", force: :cascade do |t|
    t.bigint "syndicate_group_id"
    t.bigint "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.index ["role_id"], name: "index_syndicate_members_on_role_id"
    t.index ["syndicate_group_id"], name: "index_syndicate_members_on_syndicate_group_id"
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
    t.text "about"
  end

  create_table "terms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "enabled", default: false
    t.jsonb "custom_input", default: {}
    t.bigint "deal_id"
    t.bigint "field_attribute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_terms_on_deal_id"
    t.index ["field_attribute_id"], name: "index_terms_on_field_attribute_id"
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
    t.boolean "deactivated", default: false
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
  add_foreign_key "deals", "users"
  add_foreign_key "invites", "users", column: "invitee_id"
end
