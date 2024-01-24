class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.integer :transaction_type
      t.integer :status, default: 0
      t.integer :method, default: 0
      t.string :description
      t.datetime :timestamp
      
      t.references :wallet, foreign_key: true

      t.timestamps
    end
  end
end
