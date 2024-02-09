class DealTargetToBigint < ActiveRecord::Migration[7.0]
  def change
    change_column :deals, :target, :bigint
  end
end
