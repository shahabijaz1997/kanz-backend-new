class UpdateStartupProfile < ActiveRecord::Migration[7.0]
  def change
    rename_table :startup_profiles, :fund_raiser_profiles

    rename_column :fund_raiser_profiles, :country_id, :residence_id
    rename_column :fund_raiser_profiles, :startup_id, :fund_raiser_id

    change_column :fund_raiser_profiles, :company_name, :string, null: true
    change_column :fund_raiser_profiles, :legal_name, :string, null: true

    add_column :fund_raiser_profiles, :nationality_id, :bigint
    add_column :fund_raiser_profiles, :no_of_properties, :integer
  end
end
