class CreateInvestorsPhilosophy < ActiveRecord::Migration[7.0]
  def change
    create_table :investors_philosophies do |t|
      t.integer :question_id
      t.integer :user_id
      t.string  :answer
      t.boolean :is_range
      t.float   :lower_limit
      t.float   :uper_limit

      t.timestamps
    end
  end
end
