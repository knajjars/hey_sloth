module CollectHelper
  def embed_tweet(t)
    tweet = TwitterApi.client.oembed(t)
    raw(tweet.html)
  end
end
