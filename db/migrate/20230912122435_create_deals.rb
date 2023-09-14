class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals, id: :uuid do |t|
      t.decimal :target
      t.integer :type, default: 0
      t.integer :status, default: 0
      t.datetime :start_at
      t.datetime :end_at
      t.datetime :submitted_at
      t.references :author, index: true, foreign_key: { to_table: :users }, null: false
      t.integer :success_benchmark
      t.integer :acheivements
      t.boolean :agreed_with_kanz_terms, default: false
      t.timestamps
    end
  end
end
