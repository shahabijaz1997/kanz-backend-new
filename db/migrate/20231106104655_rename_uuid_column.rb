class RenameUuidColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :deals, :uuid, :token
  end
end
