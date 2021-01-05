class CreateCollectLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :collect_links do |t|
      t.string :collect_code, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :collect_links, :collect_code, unique: true
  end
end
