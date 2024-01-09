class AddDiscoveryMethodToInvite < ActiveRecord::Migration[7.0]
  def change
    add_column :invites, :discovery_method, :integer, default: 0
  end
end
