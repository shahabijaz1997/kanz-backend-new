class CreateJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :fields_sections do |t|
      t.references :field, index: true, foreign_key: { to_table: :field_attributes }, null: false
      t.references :section, foreign_key: true, index: true
    end
  end
end
