class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :message, null: false
      t.string :message_ar, null: false
      t.references :recipient, index: true
      t.integer :status, default: 0
      t.integer :kind, default: 0
      t.references :activity, index: true

      t.timestamps
    end
  end
end
