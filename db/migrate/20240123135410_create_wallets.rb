class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.decimal :balance, default: 0.0, precision: 10, scale: 2
      
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
