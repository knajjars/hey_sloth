class AddSlugToShareableLinks < ActiveRecord::Migration[6.1]
  def change
    add_column :shareable_links, :slug, :string
    add_index :shareable_links, :slug, unique: true
  end
end
