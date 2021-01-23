class CreateShareableLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :shareable_links do |t|
      t.string :tag
      t.text :note
      t.boolean :social_link_required, default: false
      t.boolean :job_required, default: false
      t.boolean :image_required, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
