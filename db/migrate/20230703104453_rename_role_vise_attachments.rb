class RenameRoleViseAttachments < ActiveRecord::Migration[7.0]
  def change
    rename_table :role_vise_attachments, :attachment_configs
  end
end
