class UserTypeAndMetaInfo < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :role, :string, default: 'investor'
    add_column :users, :meta_info, :jsonb, default: {}
  end

  def down
    remove_column :users, :role
    remove_column :users, :meta_info
  end
end
