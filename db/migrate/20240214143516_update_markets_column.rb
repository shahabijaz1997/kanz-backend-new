class UpdateMarketsColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :deals, :markets
    add_column :deals, :markets, :string, array: true, default: []
    change_column :deals, :valuation_multiple, :float, default: 1.0
  end
end
