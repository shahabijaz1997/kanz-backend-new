class UpdateSections < ActiveRecord::Migration[7.0]
  def change
    rename_column :sections, :button_label, :add_more_label
    rename_column :sections, :button_label_ar, :add_more_label_ar
    add_column :sections, :description_link, :jsonb, default: {}
  end
end
