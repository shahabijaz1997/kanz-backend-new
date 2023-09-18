class CreateTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :terms, id: :uuid do |t|
      t.string :statement
      t.string :statement_ar
      t.boolean :enabled
      t.decimal :value
      t.references :deal, index: true
      t.timestamps   
    end
  end
end
