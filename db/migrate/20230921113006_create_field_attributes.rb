class CreateFieldAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :field_attributes do |t|
      t.integer :index, default: 0
      t.string :statement
      t.string :statement_ar
      t.string :label
      t.string :label_ar
      t.text :description
      t.text :description_ar
      t.boolean :is_required
      t.boolean :is_multiple
      t.string :add_more_label
      t.string :add_more_label_ar
      t.integer :field_type, default: 0
      t.jsonb :decription_link, default: {}
      t.string :permitted_types, array: true
      t.jsonb :size_constraints, default: {}
      t.float :suggestions, array: true, default: []
      t.string :field_mapping
      t.bigint :dependent_id
      t.timestamps
    end
  end
end
