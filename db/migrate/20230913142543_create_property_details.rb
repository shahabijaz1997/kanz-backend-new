class CreatePropertyDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :property_details, id: :uuid do |t|
      t.references :country, index: true
      t.string :state
      t.string :city
      t.string :area
      t.string :location
      t.string :building_name
      t.string :street_address
      t.integer :size_unit, default: 0
      t.float :size
      t.boolean :has_bedrooms
      t.integer :no_bedrooms
      t.boolean :has_kitchen
      t.integer :no_kitchen
      t.boolean :has_washroom
      t.integer :no_washrooms
      t.boolean :has_parking
      t.integer :parking_capacity
      t.boolean :has_swimming_pool
      t.integer :swimming_pool_type, default: 0
      t.boolean :is_rental
      t.integer :rental_period, default: 0
      t.decimal :rental_amount
      t.float :dividend_yeild
      t.float :yearly_appreciation
      t.jsonb :external_links, default: {}
      t.references :deal, index: true
      t.timestamps
    end
  end
end
