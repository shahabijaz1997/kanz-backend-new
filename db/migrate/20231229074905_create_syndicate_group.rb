class CreateSyndicateGroup < ActiveRecord::Migration[7.0]
  def change
    create_table :syndicate_groups do |t|
      t.string :title
      t.references :syndicate, index: true
      t.timestamps
    end
  end
end
