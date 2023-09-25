class CreateDependencyTree < ActiveRecord::Migration[7.0]
  def change
    create_table :dependency_trees do |t|
      t.integer :condition, default: 0
      t.string :value
      t.references :dependable, polymorphic: true, null: false
      t.references :dependent, polymorphic: true, null: false
      t.integer :operation, default: 0

      t.timestamps
    end
  end
end
