class RenameDealsAuthorId < ActiveRecord::Migration[7.0]
  def change
    rename_column :deals, :author_id, :user_id
  end
end
