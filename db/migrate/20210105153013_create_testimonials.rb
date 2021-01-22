class CreateTestimonials < ActiveRecord::Migration[6.1]
  def change
    create_table :testimonials do |t|
      t.string :name, null: false
      t.string :company
      t.string :role
      t.string :social_link
      t.text :testimonial, null: false, default: ""
      t.references :user, null: false, foreign_key: true
      t.integer :source, default: 0
      t.string :tweet_status_id
      t.text :tweet_url
      t.text :tweet_image_url
      t.string :tweet_user_id
      t.boolean :showcase, default: false

      t.timestamps
    end
    add_index :testimonials, :tweet_status_id
  end
end
