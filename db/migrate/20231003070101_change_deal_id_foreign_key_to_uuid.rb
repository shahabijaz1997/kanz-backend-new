class ChangeDealIdForeignKeyToUuid < ActiveRecord::Migration[7.0]
  def change
    change_table(:terms) do |t|
      t.remove :deal_id
      t.references :deal, foreign_key: true, type: :uuid
    end
    change_table(:funding_rounds) do |t|
      t.remove :deal_id
      t.references :deal, foreign_key: true, type: :uuid
    end
    change_table(:property_details) do |t|
      t.remove :deal_id
      t.references :deal, foreign_key: true, type: :uuid
    end
    change_table(:features) do |t|
      t.remove :deal_id
      t.references :deal, foreign_key: true, type: :uuid
    end
  end
end
