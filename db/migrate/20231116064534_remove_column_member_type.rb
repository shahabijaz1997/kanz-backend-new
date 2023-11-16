class RemoveColumnMemberType < ActiveRecord::Migration[7.0]
  def change
    remove_column :syndicate_members, :member_type
  end
end
