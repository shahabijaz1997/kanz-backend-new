class CreateRealtorsProfileTable < ActiveRecord::Migration[7.0]
  def change
    create_table :realtor_profiles do |t|
      t.integer    :no_of_properties
      t.references :nationality, foreign: true
      t.references :residence, foreign: true
      t.references :realtor, foreign: true

      t.timestamps
    end
  end
end
