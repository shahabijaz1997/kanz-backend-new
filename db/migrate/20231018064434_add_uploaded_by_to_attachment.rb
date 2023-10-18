class AddUploadedByToAttachment < ActiveRecord::Migration[7.0]
  def change
    add_reference :attachments, :uploaded_by, null: true, polymorphic: true
  end
end
