class ChangeAccreditionAndResidenceColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :investor_profiles, :residence
    remove_column :investor_profiles, :accreditation
    
    change_table :investor_profiles do |t|
      t.references :residence
      t.references :accreditation_option
    end
  end
end
