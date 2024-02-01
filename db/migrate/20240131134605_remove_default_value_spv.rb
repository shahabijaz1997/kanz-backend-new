class RemoveDefaultValueSpv < ActiveRecord::Migration[7.0]
  def change
    change_column :spvs, :management_agreements, :string, default: ''
    change_column :spvs, :parent_company, :string, default: ''
  end
end
