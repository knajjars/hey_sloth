class AddTweetFieldsToTestimonials < ActiveRecord::Migration[6.1]
  def change
    add_column :testimonials, :is_a_tweet, :boolean, default: false, null: false
    add_column :testimonials, :tweet_status_id, :string
    add_column :testimonials, :tweet_url, :text
    add_column :testimonials, :tweet_image_url, :text
    add_column :testimonials, :tweet_user_id, :string
  end
end
