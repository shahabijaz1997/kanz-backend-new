class CreateJoinTableQuestionsSections < ActiveRecord::Migration[7.0]
  def change
    create_join_table :questions, :sections do |t|
      t.index [:question_id, :section_id]
    end
  end
end
