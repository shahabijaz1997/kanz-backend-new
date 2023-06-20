class AddArabicColumns < ActiveRecord::Migration[7.0]
  def change
    change_table :questions, bulk: true do |t|
      t.string :title_ar
      t.string :statement_ar
      t.string :category_ar
      t.text   :description_ar
    end
  end
end
