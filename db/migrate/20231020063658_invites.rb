class Invites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites do |t|
      t.references :user
      t.datetime :expire_at
      t.references :invitee, index: true, foreign_key: { to_table: :users }, null: false
      t.references :eventable, polymorphic: true
      t.string :message, null: true
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end
