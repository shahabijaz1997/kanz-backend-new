class RemoveQuestionIdFromOption < ActiveRecord::Migration[7.0]
  def change
    remove_column :options, :question_id
  end
end
