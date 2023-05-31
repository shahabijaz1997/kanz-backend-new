class CreateInvestorProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :investor_profiles do |t|
      t.string  :residence, null: false
      t.string  :location, null: false
      t.string  :accreditation, null: false
      t.boolean :accepted_investment_criteria
      t.references :country, index: true
      t.references :investor, index: true

      t.timestamps
    end
  end
end
