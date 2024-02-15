class AddColumnToStoreMultiple < ActiveRecord::Migration[7.0]
  def up
    add_column :deals, :valuation_multiple, :float, default: 1.0
    add_column :deals, :markets, :string, array: true, default: []
  end
end
