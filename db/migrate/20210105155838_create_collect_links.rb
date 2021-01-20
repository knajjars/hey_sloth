class CreateCollectLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :collect_links do |t|
      t.string :tag, default: false
      t.string :note
      t.boolean :social_link_required, default: false
      t.boolean :email_required, default: false
      t.boolean :job_required, default: false
      t.integer :allowed_sources, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :collect_links, :tag, unique: true
  end
end
