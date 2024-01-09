class AddAboutFieldSyndicate < ActiveRecord::Migration[7.0]
  def change
    add_column :syndicate_profiles, :about, :text
  end
end
