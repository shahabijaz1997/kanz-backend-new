class CreateUniqueSellingPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :unique_selling_points, id: :uuid do |t|
      t.string :title
      t.text :description
      t.references :porperty_detail, index: true
      t.timestamps
    end
  end
end
