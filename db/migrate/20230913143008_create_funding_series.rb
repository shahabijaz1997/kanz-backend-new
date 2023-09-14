class CreateFundingSeries < ActiveRecord::Migration[7.0]
  def change
    create_table :funding_rounds, id: :uuid do |t|
      t.integer :round, default: 0
      t.integer :instrument_type, default: 0
      t.integer :instrument_sub_type, default: 0    
      t.integer :valuation_phase, default: 0
      t.decimal :valuation
      t.references :deal, index: true
      t.timestamps     
    end
  end
end
