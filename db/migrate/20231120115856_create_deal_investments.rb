class CreateDealInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments do |t|
      t.decimal :amount, null: false
      t.references :deal, index: true, null: false
      t.references :user, index: true, null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
