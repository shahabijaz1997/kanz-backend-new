class CreateQuestion < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer :index
      t.boolean :required
      t.integer :question_type, default: 0
      t.string  :category
      t.string  :statement
      t.text    :description
      t.jsonb   :options

      t.timestamps
    end
  end
end
