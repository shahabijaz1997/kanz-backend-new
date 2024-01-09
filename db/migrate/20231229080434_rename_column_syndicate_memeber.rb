class RenameColumnSyndicateMemeber < ActiveRecord::Migration[7.0]
  def change
    rename_column :syndicate_members, :syndicate_id, :syndicate_group_id 
  end
end
