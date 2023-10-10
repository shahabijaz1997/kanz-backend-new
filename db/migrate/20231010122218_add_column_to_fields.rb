class AddColumnToFields < ActiveRecord::Migration[7.0]
  def change
    add_column :field_attributes, :input_type, :integer, default: 0
  end
end
