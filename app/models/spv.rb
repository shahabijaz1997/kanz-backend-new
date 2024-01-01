class Spv < ApplicationRecord
  include SpvStepper

  # enum status: { added_spv: 0 }
  # Step 1 Entity Information
  validates :legal_name, :date_of_incorporation, :place_of_incorporation, :legal_structure, :jurisdiction, :registered_office_address, presence: true
  belongs_to :registration_certificate, class_name: 'Attachment', optional: true
  belongs_to :created_by, class_name: 'AdminUser', optional: true

  # step 2 Governance and Management
  validates :directors, presence: true #[{name: 'Ahmad', role: 'Ceo & Lead Investor']}, {name: 'Sarah', role: 'cfo'}]
  belongs_to :governance_structure, optional: true #: The Board consists of the CEO, CFO, and two independent directors.

  # step 3 Investment Details
  validates :investment_nature, :capital_raised, :terms, presence: true
  validates_numaricality :capital_raised, :investment_thresholds
  belongs_to :investment_strategy, optional: true #: Acquire and develop a mixed-use complex in Business Bay, Dubai.
  belongs_to :valuation_report, optional: true #: Appraised by XYZ Appraisals on February 20, 2023.

  # Step 4 Regulatory Compliance:
  validates :risk_disclosures, presence: true # Included in the investment memorandum.
  belongs_to :aml_kyc_document, optional: true # AML/KYC Documentation: Detailed for all investors, with enhanced due diligence for Ahmed due to his position.
  belongs_to :dfsa_compliance_regulations, optional: true #Overseen by internal compliance officers.
  belongs_to :data_protection_compliance, optional: true # In line with DIFC Data Protection Law No. 5 of 2020.

  # Step 5 Financial Information
  validates :bank_name, :branch_name, :account_no, :account_title, :capital_requirements, presence: true
  belongs_to :audited_financial_statements, optional: true #: Audited by RST Auditors for the year 2023.
  belongs_to :financial_projections, optional: true #: 7-year projection with a cumulative ROI of 70%.
    
  # Step 6 Reporting Requirements:
  belongs_to :financial_reporting, optional: true #: Semi-annual financial statements.
  belongs_to :investor_reporting, optional: true #: Annual report to investors.
  belongs_to :performance_metrics, optional: true #: Yearly assessment of development progress and financial performance.
    
  # Contractual Documents:
  belongs_to :shareholder_agreements, optional: true #: Primary agreement between Ahmed and other investors.
  belongs_to :property_deeds, optional: true #: Title for the plot in Business Bay, Dubai.
  belongs_to :loan_agreement, optional: true #: Personal investment by Ahmed,; no loan.
  belongs_to :service_provider_contracts, optional: true #: Construction contract with LMN Developers.
    
  # Operational Details:
  belongs_to :business_plan, optional: true #: To develop a high-end mixed-use complex within 5 years.
  belongs_to :service_providers, optional: true #: Architectural services by ABC Architects; Legal by DEF Law.
  belongs_to :insurance_policies, optional: true #: Comprehensive construction and property insurance.
    
  # Exit Strategy:
  validates :exit_options, presence: true 
  belongs_to :divestment_process, optional: true
    
  # Investor Relations:
  belongs_to :communication_channels, optional: true #: Direct line to Ahmed for major investors, email updates for others.
end
