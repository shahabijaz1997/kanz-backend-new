class CreateExternalLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :external_links do |t|
      t.string :url
      t.integer :index
      t.references :deal, index: true
      t.references :field_attribute, index: true

      t.timestamps
    end
  end
end
