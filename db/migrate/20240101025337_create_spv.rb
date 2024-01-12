class CreateSpv < ActiveRecord::Migration[7.0]
  def change
    create_table :spvs do |t|
      # Step 1 Entity Information
      t.string :legal_name, null: false
      t.date :date_of_incorporation, null: false
      t.string :place_of_incorporation, null: false
      t.references :registration_certificate
      t.string :legal_structure
      t.string :jurisdiction
      t.string :registered_office_address

      # step 2 Governance and Management
      t.jsonb :directors, default: {} #[{name: 'Ahmad', role: 'Ceo & Lead Investor']}, {name: 'Sarah', role: 'cfo'}]
      t.references :governance_structure #: The Board consists of the CEO, CFO, and two independent directors.
      t.string :management_agreements, default: 'None, as management is internal.'
      t.string :parent_company, default: 'Not applicable, independent entity.'

      # step 3 Investment Details
      t.string :investment_nature #Commercial property acquisition and development. dropdown or string
      t.references :investment_strategy #: Acquire and develop a mixed-use complex in Business Bay, Dubai.
      t.decimal :capital_raised
      t.decimal :investment_thresholds
      t.references :valuation_report #: Appraised by XYZ Appraisals on February 20, 2023.
      t.text :terms

      # Step 4 Regulatory Compliance:
      t.references :aml_kyc_document # AML/KYC Documentation: Detailed for all investors, with enhanced due diligence for Ahmed due to his position.
      t.references :dfsa_compliance_regulations #Overseen by internal compliance officers.
      t.text :risk_disclosures # Included in the investment memorandum.
      t.references :data_protection_compliance # In line with DIFC Data Protection Law No. 5 of 2020.

      # Step 5 Financial Information
      t.string :bank_name
      t.string :branch_name
      t.string :account_no
      t.string :account_title
      t.text :capital_requirements # Initial investment of AED 30 million by Ahmed.
      t.references :audited_financial_statements #: Audited by RST Auditors for the year 2023.
      t.references :financial_projections #: 7-year projection with a cumulative ROI of 70%.
      
      # Step 6 Reporting Requirements:
      t.references :financial_reporting #: Semi-annual financial statements.
      t.references :investor_reporting #: Annual report to investors.
      t.references :performance_metrics #: Yearly assessment of development progress and financial performance.
      
      # Contractual Documents:
      t.references :shareholder_agreements #: Primary agreement between Ahmed and other investors.
      t.references :property_deeds #: Title for the plot in Business Bay, Dubai.
      t.references :loan_agreement #: Personal investment by Ahmed,; no loan.
      t.references :service_provider_contracts #: Construction contract with LMN Developers.
      
      # Operational Details:
      t.references :business_plan #: To develop a high-end mixed-use complex within 5 years.
      t.references :service_providers #: Architectural services by ABC Architects; Legal by DEF Law.
      t.references :insurance_policies #: Comprehensive construction and property insurance.
      
      # Exit Strategy:
      t.text :exit_options #: Sell the developed property after 7 years or attract anchor tenants.
      t.references :divestment_process #: Managed by Ahmed in consultation with other investors.
      
      # Investor Relations:
      t.references :communication_channels #: Direct line to Ahmed for major investors, email updates for others.
      t.text :investor_queries #: Managed personally by Ahmed and the CFO.

      t.bigint :created_by
      t.integer :status, default: 0
      t.bigint :deal_id
      t.integer :closing_model, default: 0

      t.timestamps
    end
  end
end
