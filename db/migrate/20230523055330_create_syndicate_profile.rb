class CreateSyndicateProfile < ActiveRecord::Migration[7.0]
  def change
    create_table :syndicate_profiles do |t|
      t.string :name
      t.string :tagline
      t.boolean :previously_raised
      t.float :raised_amount
      t.integer :no_times_raised
      t.string :industry_market, array: true, default: []
      t.string :region 
      t.string :profile_link
      t.string :dealflow
      t.string :logo
      t.integer :syndicate_id
      t.timestamps
    end
  end
end
