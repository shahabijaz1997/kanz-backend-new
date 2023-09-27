class AddMappingColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :field_attributes, :field_mapping, :string
  end
end
