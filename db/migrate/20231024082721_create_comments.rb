class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :message
      t.references :author, null: false
      t.references :thread
      t.references :deal, null: false
      t.integer :state, default: 0
      t.references :recipient

      t.timestamps
    end
  end
end
