class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.decimal :target
      t.integer :deal_type, default: 0
      t.integer :status, default: 0
      t.datetime :start_at
      t.datetime :end_at
      t.datetime :submitted_at
      t.references :author, index: true, foreign_key: { to_table: :users }, null: false
      t.integer :success_benchmark
      t.float :how_much_funded
      t.boolean :agreed_with_kanz_terms, default: false
      t.string :title
      t.text :description
      t.uuid :uuid, default: "gen_random_uuid()"
      t.timestamps
    end
  end
end
