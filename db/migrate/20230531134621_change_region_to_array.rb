class ChangeRegionToArray < ActiveRecord::Migration[7.0]
  def change
    change_column :syndicate_profiles, :region, "varchar[] USING (string_to_array(region, ','))"
  end
end
