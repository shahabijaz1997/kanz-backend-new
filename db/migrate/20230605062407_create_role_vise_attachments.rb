class CreateRoleViseAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :role_vise_attachments do |t|
      t.string :name, null: false
      t.string :label
      t.integer :index
      t.boolean :required, default: true
      t.string :allowed_file_types, array: true
      t.references :role

      t.timestamps
    end
  end
end
