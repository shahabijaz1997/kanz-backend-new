class AddRoleToSyndicateMembers < ActiveRecord::Migration[7.0]
  def change
    remove_column :syndicate_members, :connection
    add_column :syndicate_members, :role_id, :bigint
    add_index :syndicate_members, :role_id
  end
end
