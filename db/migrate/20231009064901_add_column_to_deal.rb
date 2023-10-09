class AddColumnToDeal < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :current_state, :jsonb, default: {}
  end
end
