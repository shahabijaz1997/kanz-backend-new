class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :title, null: false, unique: true

      t.timestamps
    end
  end
end
