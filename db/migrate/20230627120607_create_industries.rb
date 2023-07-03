class CreateIndustries < ActiveRecord::Migration[7.0]
  def change
    create_table :industries do |t|
      t.string :name, null: false
      t.string :name_ar, null: false

      t.timestamps
    end
  end
end
