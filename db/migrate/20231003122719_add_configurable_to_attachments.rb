class AddConfigurableToAttachments < ActiveRecord::Migration[7.0]
  def change
    rename_column :attachments, :attachment_config_id, :configurable_id
    add_column :attachments, :configurable_type, :string, default: 'AttachmentConfig'
  end
end
