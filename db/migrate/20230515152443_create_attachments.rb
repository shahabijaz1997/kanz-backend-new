class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.references :parent, polymorphic: true, index: true
      t.string     :name
      t.string     :attachment_kind
      
      t.timestamps
    end
  end
end
