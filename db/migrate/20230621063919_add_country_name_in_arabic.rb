class AddCountryNameInArabic < ActiveRecord::Migration[7.0]
  def change
    add_column :countries, :name_ar, :string
  end
end
