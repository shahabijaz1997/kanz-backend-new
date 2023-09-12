class ModifyStartupAndSyndicateProfile < ActiveRecord::Migration[7.0]
  def change
    change_column_null :startup_profiles, :total_capital_raised, true
    change_column_null :startup_profiles, :current_round_capital_target, true
    remove_column :syndicate_profiles, :logo
    remove_column :startup_profiles, :logo
  end
end
