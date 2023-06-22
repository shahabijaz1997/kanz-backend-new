class AddLanguageToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :language, :string, limit: 5, default: 'en'
  end
end
