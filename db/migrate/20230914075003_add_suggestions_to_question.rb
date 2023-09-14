class AddSuggestionsToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :suggestions, :jsonb, default: {}
  end
end
