class AddColumnPurposeToInvites < ActiveRecord::Migration[7.0]
  def change
    add_column :invites, :purpose, :integer, default: 0
  end
end
