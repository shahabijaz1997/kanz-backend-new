class AddModelToDeal < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :model, :integer, default: '0'
  end
end
