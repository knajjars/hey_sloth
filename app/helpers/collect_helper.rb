module CollectHelper
  def tweets_timeline
    if current_user.twitter?
      @tweets = current_user.twitter.mentions_timeline(tweet_mode: "extended")
      unless @tweets.empty?
        render 'tweet/collect_tweets'
      end
    else
      raw "<p>Please link your Twitter account in your #{link_to 'profile', edit_user_registration_path} first.</p>"
    end
  end
end
