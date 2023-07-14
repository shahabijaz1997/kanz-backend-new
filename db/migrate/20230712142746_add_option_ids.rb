class AddOptionIds < ActiveRecord::Migration[7.0]
  def change
    add_column :users_responses, :selected_option_ids, :bigint, array: true, default: []
    change_column :users_responses, :answers, :text, default: ''
    rename_column :users_responses, :answers, :answer
    remove_column :users_responses, :answer_meta
  end
end
