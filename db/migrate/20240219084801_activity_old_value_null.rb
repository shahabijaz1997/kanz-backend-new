class ActivityOldValueNull < ActiveRecord::Migration[7.0]
  def change
    change_column :activities, :field_name, :string, null: true
    change_column :activities, :old_value, :string, null: true
  end
end
