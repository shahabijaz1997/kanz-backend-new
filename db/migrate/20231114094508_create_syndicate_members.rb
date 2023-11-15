class CreateSyndicateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :syndicate_members do |t|
      t.references :syndicate, index: true
      t.references :member, null: false, polymorphic: true, index: false
      t.integer :connection, default: 0
      t.timestamps
    end
  end
end
