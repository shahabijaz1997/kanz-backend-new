class AddDealClosingDate < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :closing_date, :datetime
  end
end
