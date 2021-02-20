class AddSlugToFireLinks < ActiveRecord::Migration[6.1]
  def change
    add_column :fire_links, :slug, :string
    add_index :fire_links, :slug, unique: true
  end
end
