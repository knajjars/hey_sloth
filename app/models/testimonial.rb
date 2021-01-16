class Testimonial < ApplicationRecord
  belongs_to :user

  def self.tweets
    where("is_a_tweet = true")
  end
end
