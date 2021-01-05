class CreateTestimonials < ActiveRecord::Migration[6.1]
  def change
    create_table :testimonials do |t|
      t.string :user_name
      t.string :user_company
      t.string :user_role
      t.string :user_link
      t.string :user_testimonial

      t.timestamps
    end
  end
end
