class CreateFireLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :fire_links do |t|
      t.string :url, null: false
      t.boolean :job_required, default: false
      t.boolean :image_required, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
