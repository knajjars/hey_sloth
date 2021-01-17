class CollectController < ApplicationController

  before_action :get_collected_tweets, only: [:twitter_search, :twitter_post_new]

  def get_send_email
  end

  def post_send_email
    email_addresses = params[:email_addresses].reject { |e| e.empty? }
    email_addresses.each do |email_address|
      CollectMailer.new_testimonial(email_address, current_user).deliver
    end

    redirect_to collect_send_email_path, notice: "Successfully sent email to recipients!"
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

  def video
  end

  def twitter_search
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

    redirect_back fallback_location: app_root_path, notice: "Successfully collected twitter post!"
  end

  def delete_tweet
    Testimonial.find_by(tweet_status_id: params["status_id"]).destroy

    redirect_back fallback_location: app_root_path, notice: "Removed twitter post!"
  end

  private

  def tweet_params
    ActionController::Parameters.new(JSON.parse(params.require(:tweet))).permit(:user_name, :text, :status, :url, :user_id, :image_url)
  end

  def get_collected_tweets
    @collected_tweets = current_user.testimonials.tweets
  end

end
