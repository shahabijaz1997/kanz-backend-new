
class RenameFundingRoundColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :funding_rounds, :round, :round_id
    rename_column :funding_rounds, :instrument_type, :instrument_type_id
    rename_column :funding_rounds, :safe_type, :safe_type_id
    rename_column :funding_rounds, :equity_type, :equity_type_id
    rename_column :funding_rounds, :valuation_phase, :valuation_phase_id
  end
end
