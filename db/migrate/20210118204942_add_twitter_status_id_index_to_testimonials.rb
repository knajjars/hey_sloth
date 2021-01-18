class AddTwitterStatusIdIndexToTestimonials < ActiveRecord::Migration[6.1]
  def change
    add_index :testimonials, :tweet_status_id
  end
end
