class CreateExchangeRates < ActiveRecord::Migration[7.0]
  def change
    create_table :exchange_rates do |t|
      t.decimal :rate, precision: 10, scale: 4, null: false
      t.boolean :current, default: true

      t.timestamps
    end
  end
end
