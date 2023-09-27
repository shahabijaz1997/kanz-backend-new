class UpdateTerms < ActiveRecord::Migration[7.0]
  def change
    add_column :terms, :field_attribute_id, :bigint
    add_column :terms, :custom_input, :jsonb, default: {}
    remove_column :terms, :value
    remove_column :terms, :statement
    remove_column :terms, :statement_ar
  end
end
