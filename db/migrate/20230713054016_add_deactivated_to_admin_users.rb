class AddDeactivatedToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :deactivated, :boolean
  end
end
