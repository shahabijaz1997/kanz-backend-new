class AddTitleAndDescriptionToDeal < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :title, :string
    add_column :deals, :description, :text

    remove_column :property_details, :title
    remove_column :property_details, :description
  end
end
