class AddSlugToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :slug, :string, unique: true
  end
end
