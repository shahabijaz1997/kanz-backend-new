class CreateSection < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.integer :index, default: 0
      t.string :title, limit: 50 
      t.string :title_ar, limit: 50
      t.string :description
      t.string :description_ar
      t.boolean :is_multiple
      t.string :button_label, limit: 50
      t.string :button_label_ar, limit: 50
      t.references :stepper, index: true

      t.timestamps
    end
  end
end
