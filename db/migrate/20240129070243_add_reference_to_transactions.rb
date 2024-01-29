class AddReferenceToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :transactable, polymorphic: true
  end
end
