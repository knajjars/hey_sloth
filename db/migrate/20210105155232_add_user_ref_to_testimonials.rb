class AddUserRefToTestimonials < ActiveRecord::Migration[6.1]
  def change
    add_reference :testimonials, :user, null: false, foreign_key: true
  end
end
