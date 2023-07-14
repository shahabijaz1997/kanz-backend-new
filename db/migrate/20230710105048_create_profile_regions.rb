class CreateProfileRegions < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles_regions do |t|
      t.references :profile, polymorphic: true, index: true
      t.references :region
      t.timestamps
    end
  end
end
