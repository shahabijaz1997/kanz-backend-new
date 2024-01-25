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
  has_one_attached :registration_certificate #1
  has_one_attached :governance_structure #2
  has_one_attached :investment_strategy #3
  has_one_attached :valuation_report #3
  has_one_attached :aml_kyc_document #4
  has_one_attached :dfsa_compliance_regulations #4
  has_one_attached :data_protection_compliance #4
  has_one_attached :audited_financial_statements #5
  has_one_attached :financial_projections #5
  has_one_attached :financial_reporting #6
  has_one_attached :investor_reporting #6
  has_one_attached :performance_metrics #6
  has_one_attached :shareholder_agreements #7
  has_one_attached :property_deeds #7
  has_one_attached :loan_agreement #7
  has_one_attached :service_provider_contracts #7
  has_one_attached :business_plan #8
  has_one_attached :service_providers #8
  has_one_attached :insurance_policies #8
  has_one_attached :divestment_process #9
  has_one_attached :communication_channels #10

  scope :latest_first, -> { order(created_at: :desc) }

  def registration_certificate_url
    Rails.env.development? ? ActiveStorage::Blob.service.path_for(registration_certificate.key) : registration_certificate.url if registration_certificate.attached?
  end
end
