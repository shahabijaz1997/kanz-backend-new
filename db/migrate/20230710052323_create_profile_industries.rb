class CreateProfileIndustries < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles_industries do |t|
      t.references :profile, polymorphic: true, index: true
      t.references :industry

      t.timestamps
    end
  end
end
