class AddConditionToSeection < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :condition, :string, default: ''
  end
end
