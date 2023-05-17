class AddTypeColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :type, :string, dafault: 'investor'
    add_column :questionnaires, :type, :string, dafault: 'investment_philosophy'
  end
end
