class Testimonial < ApplicationRecord
  belongs_to :user
  has_one_attached :video

  def self.tweets
    where("is_a_tweet = true")
  end
end
