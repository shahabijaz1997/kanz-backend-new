class ChangePropertyDetailColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :property_details, :rental_period, :bigint
    rename_column :property_details, :rental_period, :rental_period_id
    change_column :property_details, :swimming_pool_type, :bigint
    rename_column :property_details, :swimming_pool_type, :swimming_pool_id
  end
end
