class AddSectionIdToFields < ActiveRecord::Migration[7.0]
  def change
    add_column :field_attributes, :section_id, :bigint
  end
end
