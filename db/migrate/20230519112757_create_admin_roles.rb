class CreateAdminRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_roles do |t|
      t.string :title

      t.timestamps
    end
  end
end
