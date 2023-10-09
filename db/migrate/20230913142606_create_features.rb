class CreateFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :features do |t|
      t.string :title
      t.text :description
      t.references :deal, index: true
      t.references :field_attribute, index: true
      t.bigint :sibling_id

      t.timestamps
    end
  end
end
