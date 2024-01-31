class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.references :author
      t.integer :status, default: 0

      t.references :approved_by

      t.timestamps
    end
  end
end
