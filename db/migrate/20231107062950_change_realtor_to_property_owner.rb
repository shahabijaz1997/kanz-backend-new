class ChangeRealtorToPropertyOwner < ActiveRecord::Migration[7.0]
  def change
    rename_table :realtor_profiles, :property_owner_profiles
    rename_column :property_owner_profiles, :realtor_id, :property_owner_id

    User.where(type: 'Realtor').update_all(type: 'PropertyOwner')
  end
end
