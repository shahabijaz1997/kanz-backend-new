class UpdateInvestorProfile < ActiveRecord::Migration[7.0]
  def change
    add_column    :investor_profiles, :legal_name, :string
    remove_column :investor_profiles, :location
    change_column_null(:investor_profiles, :residence, true)
  end
end
