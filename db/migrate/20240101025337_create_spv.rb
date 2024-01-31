class CreateSpv < ActiveRecord::Migration[7.0]
  def change
    create_table :spvs do |t|
      # Step 1 Entity Information
      t.string :legal_name, null: false
      t.date :date_of_incorporation, null: false
      t.string :place_of_incorporation, null: false
      t.string :legal_structure
      t.string :jurisdiction
      t.string :registered_office_address

      # step 2 Governance and Management
      t.jsonb :directors, default: {} #[{name: 'Ahmad', role: 'Ceo & Lead Investor']}, {name: 'Sarah', role: 'cfo'}]
      t.string :management_agreements, default: 'None, as management is internal.'
      t.string :parent_company, default: 'Not applicable, independent entity.'

      # step 3 Investment Details
      t.string :investment_nature #Commercial property acquisition and development. dropdown or string
      t.decimal :capital_raised
      t.decimal :investment_thresholds
      t.text :terms

      # Step 4 Regulatory Compliance:
      t.text :risk_disclosures # Included in the investment memorandum.

      # Step 5 Financial Information
      t.string :bank_name
      t.string :branch_name
      t.string :account_no
      t.string :account_title
      t.text :capital_requirements # Initial investment of AED 30 million by Ahmed.
      
      # Step 6 Reporting Requirements:
      
      # Step 7 Contractual Documents:

      # Step 8 Operational Details:
      
      # Step 9 Exit Strategy:
      t.text :exit_options #: Sell the developed property after 7 years or attract anchor tenants.
      
      # Step 10 Investor Relations:
      t.text :investor_queries #: Managed personally by Ahmed and the CFO.

      t.bigint :created_by_id
      t.integer :status, default: 0
      t.bigint :deal_id
      t.integer :closing_model, default: 0

      t.timestamps
    end
  end
end
