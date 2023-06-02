class CreateRealtorProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :realtor_profiles do |t|
      t.integer    :no_of_properties
      t.references :nationality
      t.references :residence
      t.references :realtor

      t.timestamps
    end
  end
end
