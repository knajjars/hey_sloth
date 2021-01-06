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

  def twitter_post_new
  end

  def twitter_post_create
    tweet_url = params.require(:tweet_url)
    begin
      tweet_status = tweet_url.split("/").last
      tweet_res = Client.twitter.status(tweet_status)

      Testimonial.create(
        "user": current_user,
        "user_name": tweet_res.user.name,
        "user_testimonial": tweet_res.text,
        "is_a_tweet": true,
        "tweet_status_id": tweet_status,
        "tweet_url": tweet_url,
        "tweet_user_id": tweet_res.user.id,
        "tweet_image_url": tweet_res.user.profile_image_url_https(:original))

    rescue Twitter::Error::NotFound => e
      respond_to do |format|
        format.html { redirect_to collect_twitter_post_new_path, alert: 'Please copy a valid twitter post URL.' }
      end
      return
    rescue
      format.html { redirect_to collect_twitter_post_new_path, alert: 'Something went wrong.' }
      return

    end

    respond_to do |format|
      format.html { redirect_to collect_twitter_post_new_path, notice: "Successfully collected twitter post!" }
    end
  end
end
