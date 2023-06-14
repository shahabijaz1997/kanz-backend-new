class AddCurrencyColumnToStartupProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :startup_profiles, :currency, :string, null: false, default: 'USD'
  end
end
