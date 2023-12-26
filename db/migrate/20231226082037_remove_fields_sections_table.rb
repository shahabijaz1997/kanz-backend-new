class RemoveFieldsSectionsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :fields_sections
  end
end
