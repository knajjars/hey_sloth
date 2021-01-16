module CollectHelper
  def tweets_timeline
    if current_user.authorizations.where(provider: 'twitter').empty?
      raw "<p>Please link your Twitter account in your #{link_to 'profile', edit_user_registration_path} first.</p>"
    else
      @tweets = current_user.twitter.mentions_timeline(tweet_mode: "extended")
      unless @tweets.empty?
        render 'tweet/collect_tweets'
      end
    end
  end
end
