class CreateHeyBoxes < ActiveRecord::Migration[6.1]
  def change
    create_table :hey_boxes do |t|
      t.string :tag
      t.text :note
      t.boolean :social_link_required, default: false
      t.boolean :job_required, default: false
      t.integer :allowed_sources, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :hey_boxes, :tag, unique: true
  end
end
