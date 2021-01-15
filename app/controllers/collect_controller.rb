class CollectController < ApplicationController
  def send_email
  end

  def shareable_link
    user_collect_link = current_user.collect_link
    if user_collect_link.nil?
      collect_code = Haikunator.haikunate
      @collect_link = CollectLink.create("collect_code": collect_code, user: current_user)
    else
      @collect_link = current_user.collect_link
    end
  end

  def twitter_search
    twitter_handle = params[:twitter_handle]
    if twitter_handle.nil?
      return
    end
    @tweets = TwitterApi.client.mentions_timeline(tweet_mode: "extended")
  end

  def twitter_post_new
    tweet_url = params[:tweet_url]
    unless tweet_url.nil?
      begin
        tweet_status = tweet_url.split("/").last
        @tweet = TwitterApi.client.status(tweet_status, tweet_mode: 'extended')
      rescue Twitter::Error::NotFound => e
        return redirect_to collect_twitter_post_new_path, alert: 'Please copy a valid twitter post URL.'
      rescue
        return redirect_to collect_twitter_post_new_path, alert: 'Something went wrong.'
      end
      render :twitter_post_new
    end
  end

  def twitter_post_create
    tweet = tweet_params
    Testimonial.create(
      "user": current_user,
      "user_name": tweet[:user_name],
      "user_testimonial": tweet[:text],
      "is_a_tweet": true,
      "tweet_status_id": tweet[:status],
      "tweet_url": tweet[:url],
      "tweet_user_id": tweet[:user_id],
      "tweet_image_url": tweet[:image_url]
    )
    redirect_to collect_twitter_post_new_path, notice: "Successfully collected twitter post!"
  end

  private

  def tweet_params
    ActionController::Parameters.new(JSON.parse(params.require(:tweet))).permit(:user_name, :text, :status, :url, :user_id, :image_url)
  end

end