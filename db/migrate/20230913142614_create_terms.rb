class CreateTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :terms, id: :uuid do |t|
      t.boolean :enabled
      t.jsonb :custom_input, default: {}
      t.references :deal, index: true
      t.references :field_attribute
      t.timestamps   
    end
  end
end
