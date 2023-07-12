class AddQuestionKind < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :kind, :integer, default: 0
  end
end
