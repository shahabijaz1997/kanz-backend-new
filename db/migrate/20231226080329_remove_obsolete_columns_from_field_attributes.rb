class RemoveObsoleteColumnsFromFieldAttributes < ActiveRecord::Migration[7.0]
  def change
    remove_column :field_attributes, :decription_link
    remove_column :field_attributes, :add_more_label
    remove_column :field_attributes, :add_more_label_ar
    remove_column :field_attributes, :is_multiple
  end
end
