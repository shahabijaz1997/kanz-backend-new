class AddColumnToStoreMultiple < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :valuation_multiple, :float, default: 0.0
    add_column :deals, :markets, :string
  end
end
