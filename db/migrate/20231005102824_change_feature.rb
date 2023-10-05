class ChangeFeature < ActiveRecord::Migration[7.0]
  def change
    rename_column :features, :sibling_id, :index
    change_column :features, :index, :integer
  end
end
