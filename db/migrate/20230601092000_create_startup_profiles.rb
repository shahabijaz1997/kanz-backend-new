class CreateStartupProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :startup_profiles do |t|
      t.string     :company_name, null: false
      t.string     :legal_name, null: false
      t.string     :industry_market, array: true
      t.string     :website
      t.string     :address
      t.string     :logo
      t.text       :description
      t.string     :ceo_name
      t.string     :ceo_email
      t.float      :total_capital_raised, null: false
      t.float      :current_round_capital_target, null: false
      t.references :startup
      t.references :country

      t.timestamps
    end
  end
end
