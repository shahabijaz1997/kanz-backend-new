class AddDependentToFields < ActiveRecord::Migration[7.0]
  def change
    add_column :field_attributes, :dependent_id, :bigint
  end
end
