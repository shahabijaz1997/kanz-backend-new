class ChangeColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :deals, :target, :integer
  end
end
