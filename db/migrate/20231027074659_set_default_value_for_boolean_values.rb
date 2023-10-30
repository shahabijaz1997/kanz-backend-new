class SetDefaultValueForBooleanValues < ActiveRecord::Migration[7.0]
  def change
    change_column :property_details, :has_bedrooms, :boolean, default: false
    change_column :property_details, :has_kitchen, :boolean, default: false
    change_column :property_details, :has_washroom, :boolean, default: false
    change_column :property_details, :has_parking, :boolean, default: false
    change_column :property_details, :has_swimming_pool, :boolean, default: false
    change_column :property_details, :is_rental, :boolean, default: false

    change_column :investor_profiles, :accepted_investment_criteria, :boolean, default: false

    change_column :sections, :is_multiple, :boolean, default: false

    change_column :terms, :enabled, :boolean, default: false

    change_column :field_attributes, :is_required, :boolean, default: false
    change_column :field_attributes, :is_multiple, :boolean, default: false

    change_column :options, :is_range, :boolean, default: false    
  end
end
