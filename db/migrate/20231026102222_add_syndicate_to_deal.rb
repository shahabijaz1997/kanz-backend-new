class AddSyndicateToDeal < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :syndicate_id, :bigint
    add_index :deals, :syndicate_id
  end
end
