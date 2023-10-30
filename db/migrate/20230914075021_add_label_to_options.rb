class AddLabelToOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :options, :label, :string
    add_column :options, :label_ar, :string
  end
end
