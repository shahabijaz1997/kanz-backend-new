class AddPolymorphicAssciationToQuestionnair < ActiveRecord::Migration[7.0]
  def change
    remove_column :questionnaires, :user_id
    add_column :questionnaires, :respondable_type, :string
    add_column :questionnaires, :respondable_id, :integer
    add_index :questionnaires, [:respondable_id, :respondable_type]
  end
end
