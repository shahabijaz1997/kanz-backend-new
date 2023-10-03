class AddDisplayCardToSection < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :display_card, :boolean, default: false
  end
end
