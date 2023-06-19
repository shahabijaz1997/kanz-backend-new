class AddAttachmentNameInArabic < ActiveRecord::Migration[7.0]
  def change
    add_column :role_vise_attachments, :name_ar, :string
    add_column :role_vise_attachments, :label_ar, :string
  end
end
