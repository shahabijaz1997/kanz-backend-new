class AddRoleTitleInArabic < ActiveRecord::Migration[7.0]
  def change
    add_column :roles, :title_ar, :string
  end
end
