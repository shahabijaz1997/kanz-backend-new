class ChangeFeatures < ActiveRecord::Migration[7.0]
  def change
    remove_column :features, :title_ar
    remove_column :features, :description_ar
    add_column :features, :field_attribute_id, :bigint
    add_column :features, :sibling_id, :bigint
  end
end
