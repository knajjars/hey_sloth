module MapTweetToTestimonial
  extend ActiveSupport::Concern

  def map_tweet_to_testimonial(tweet)
    { name: tweet.user.name,
      content: tweet.full_text,
      social_link: tweet.user.url.to_s,
      tweet_status_id: tweet.id,
      tweet_url: tweet.url.to_s,
      tweet_user_id: tweet.user.id,
      tweet_image_url: tweet.user.profile_image_url_https(:original).to_s,
      tweet_date: tweet.created_at,
      tweet_retweet_count: tweet.retweet_count,
      tweet_favorite_count: tweet.favorite_count,
      source: 1 }
  end
end
