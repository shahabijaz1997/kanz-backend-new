class RenameMetaInfoColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :meta_info, :profile_states
  end
end
