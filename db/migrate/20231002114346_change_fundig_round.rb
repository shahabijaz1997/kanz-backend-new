class ChangeFundigRound < ActiveRecord::Migration[7.0]
  def change
    add_column :funding_rounds, :equity_type, :integer, default: 0
    rename_column :funding_rounds, :instrument_sub_type, :safe_type
  end
end
