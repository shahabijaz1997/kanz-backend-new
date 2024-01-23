# frozen_string_literal: true

class Spv < ApplicationRecord
  attr_accessor :step

  validates :legal_name, :date_of_incorporation, :place_of_incorporation, :legal_structure,
            :jurisdiction, :registered_office_address, presence: true, if: Proc.new { |spv| spv.step == 1 } # Step 1
  validates :directors, presence: true, if: Proc.new { |spv| spv.step == 2 } # step 2
  validates :investment_nature, :capital_raised, :terms, presence: true, if: Proc.new { |spv| spv.step == 3 } #step 3
  validates :capital_raised, :investment_thresholds, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new { |spv| spv.step == 3 } # step 3
  validates :risk_disclosures, presence: true, if: Proc.new { |spv| spv.step == 4 } # step 4
  validates :bank_name, :branch_name, :account_no, :account_title, :capital_requirements, presence: true, if: Proc.new { |spv| spv.step == 5 } #step 5
  validates :exit_options, presence: true, if: Proc.new { |spv| spv.step == 9 } #step 9

  belongs_to :deal
  belongs_to :created_by, class_name: 'AdminUser', optional: true
  belongs_to :registration_certificate, class_name: 'Attachment', optional: true #1
  belongs_to :governance_structure, class_name: 'Attachment', optional: true #2
  belongs_to :investment_strategy, class_name: 'Attachment', optional: true #3
  belongs_to :valuation_report, class_name: 'Attachment', optional: true #3
  belongs_to :aml_kyc_document, class_name: 'Attachment', optional: true #4
  belongs_to :dfsa_compliance_regulations, class_name: 'Attachment', optional: true #4
  belongs_to :data_protection_compliance, class_name: 'Attachment', optional: true #4
  belongs_to :audited_financial_statements, class_name: 'Attachment', optional: true #5
  belongs_to :financial_projections, class_name: 'Attachment', optional: true #5
  belongs_to :financial_reporting, class_name: 'Attachment', optional: true #6
  belongs_to :investor_reporting, class_name: 'Attachment', optional: true #6
  belongs_to :performance_metrics, class_name: 'Attachment', optional: true #6
  belongs_to :shareholder_agreements, class_name: 'Attachment', optional: true #7
  belongs_to :property_deeds, class_name: 'Attachment', optional: true #7
  belongs_to :loan_agreement, class_name: 'Attachment', optional: true #7
  belongs_to :service_provider_contracts, class_name: 'Attachment', optional: true #7
  belongs_to :business_plan, class_name: 'Attachment', optional: true #8
  belongs_to :service_providers, class_name: 'Attachment', optional: true #8
  belongs_to :insurance_policies, class_name: 'Attachment', optional: true #8
  belongs_to :divestment_process, class_name: 'Attachment', optional: true #9
  belongs_to :communication_channels, class_name: 'Attachment', optional: true #10
end
