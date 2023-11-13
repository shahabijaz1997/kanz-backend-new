class RenameColumnYeild < ActiveRecord::Migration[7.0]
  def change
    rename_column :property_details, :dividend_yeild, :dividend_yield
  end
end
