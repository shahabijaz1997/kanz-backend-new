class AddFieldIdToPropertyDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :property_details, :field_attribute_id, :bigint
  end
end
