class CreateFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :features, id: :uuid do |t|
      t.string :title
      t.string :title_ar
      t.text :description
      t.text :description_ar
      t.references :deal, index: true
      t.timestamps
    end
  end
end
