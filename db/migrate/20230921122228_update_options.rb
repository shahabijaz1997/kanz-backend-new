class UpdateOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :options, :optionable_id, :bigint
    add_column :options, :optionable_type, :string
    add_index :options, [:optionable_type, :optionable_id]
  end
end


