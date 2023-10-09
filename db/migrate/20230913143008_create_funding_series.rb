class CreateFundingSeries < ActiveRecord::Migration[7.0]
  def change
    create_table :funding_rounds do |t|
      t.bigint :round, default: 0
      t.bigint :instrument_type, default: 0
      t.bigint :safe_type, default: 0    
      t.bigint :equity_type, default: 0    
      t.bigint :valuation_phase, default: 0
      t.decimal :valuation
      t.references :deal, index: true
      t.timestamps     
    end
  end
end
