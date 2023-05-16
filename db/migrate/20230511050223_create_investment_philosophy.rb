class CreateInvestmentPhilosophy < ActiveRecord::Migration[7.0]
  def change
    create_table :investment_philosophies do |t|
      t.integer :question_id
      t.integer :user_id
      t.text  :answers, array: true, default: []
      t.jsonb   :answer_meta
      t.timestamps
    end
  end
end
