class RenameTableQuestionnair < ActiveRecord::Migration[7.0]
  def change
    remove_index :questionnaires, name: :index_questionnaires_on_respondable_id_and_respondable_type
    remove_column :questionnaires, :respondable_type
    rename_table :questionnaires, :users_responses
    rename_column :users_responses, :respondable_id, :user_id
    add_index :users_responses, [:question_id, :user_id]
  end
end
