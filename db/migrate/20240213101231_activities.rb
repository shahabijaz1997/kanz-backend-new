class Activities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :record, polymorphic: true, null: false
      t.references :user,polymorphic: true, null: false
      t.string :field_name, null: false
      t.string :old_value, null: false
      t.string :new_value, null: false
      t.string :action

      t.timestamps
    end
  end
end
