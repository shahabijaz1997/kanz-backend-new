class CreateStepper < ActiveRecord::Migration[7.0]
  def change
    create_table :steppers do |t|
      t.integer :index
      t.integer :stepper_type, default: 0
      t.string :title, limit: 100
      t.string :title_ar, limit: 100
      t.timestamps
    end
  end
end
