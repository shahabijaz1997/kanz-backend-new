class RemoveObsoleteColumnFromSections < ActiveRecord::Migration[7.0]
  def change
    remove_column :sections, :description_link
  end
end
