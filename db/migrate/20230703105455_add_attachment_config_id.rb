class AddAttachmentConfigId < ActiveRecord::Migration[7.0]
  def change
    add_column :attachments, :attachment_config_id, :bigint
  end
end
