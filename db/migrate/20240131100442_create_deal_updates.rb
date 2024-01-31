class CreateDealUpdates < ActiveRecord::Migration[7.0]
  def change
    create_table :deal_updates do |t|
      t.text :description
      t.references :deal, null: false, foreign_key: true
      t.references :added_by, index: true, foreign_key: { to_table: :users }, null: false
      t.references :published_by, index: true, foreign_key: { to_table: :admin_users }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
