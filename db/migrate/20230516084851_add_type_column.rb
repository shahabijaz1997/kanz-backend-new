class AddTypeColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :type, :string, dafault: 'investor'
  end
end
