class CollectController < ApplicationController
  include MapTweetToTestimonial

  before_action :set_collected_tweets, only: %i[twitter_search twitter_post_new]
  before_action :set_fire_link, only: %i[from_fire_link_new from_fire_link_create send_email_create send_email_new]

  def from_fire_link_new
    @testimonial = Testimonial.new
    render_not_found if @fire_link.nil?
  end

  def from_fire_link_create
    return render_bad_request if @fire_link.nil?

    testimonial_attrs = testimonial_params.merge({ user: @fire_link.user })
    @testimonial = @fire_link.testimonials.new(testimonial_attrs)
    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to root_path, notice: 'Testimonial was successfully created.' }
      else
        format.html { render :from_fire_link_new }
      end
    end
  end

  def send_email_new
    authorize @fire_link
  end

  def send_email_create
    authorize @fire_link
    return render_bad_request if params[:email].nil?

    email_addresses = params[:email].reject(&:empty?)
    email_addresses.each do |email_address|
      CollectMailer.new_testimonial(email_address, @fire_link).deliver
    end

    redirect_to fire_link_index_path, notice: 'Successfully sent email to recipients!'
  end

  def twitter_search
    @testimonials = []
    return unless current_user.twitter?

    @twitter_handle = current_user.authorizations.first.twitter_handle
    tweets = current_user.twitter.mentions_timeline(tweet_mode: 'extended')
    tweets.each do |t|
      testimonial = Testimonial.new map_tweet_to_testimonial(t)
      @testimonials << testimonial
    end
  end

  def twitter_post_new
    tweet_url = params[:tweet_url]
    return unless tweet_url.present?

    begin
      tweet_status = tweet_url.split('/').last

      client = current_user.twitter? ? current_user.twitter : TwitterApi.client
      tweet = client.status(tweet_status, tweet_mode: 'extended')
      @testimonial = Testimonial.new map_tweet_to_testimonial(tweet)
    rescue Twitter::Error::NotFound => e
      redirect_to collect_twitter_post_new_path, alert: 'Please copy a valid twitter post URL.'
    rescue StandardError
      redirect_to collect_twitter_post_new_path, alert: 'Something went wrong.'
    end
  end

  def twitter_post_create
    tweet = tweet_params
    Testimonial.create!(
      "user": current_user,
      "name": tweet[:name],
      "content": tweet[:content],
      "source": 'tweet',
      "social_link": tweet[:social_link],
      "tweet_status_id": tweet[:tweet_status_id],
      "tweet_url": tweet[:tweet_url],
      "tweet_user_id": tweet[:tweet_user_id],
      "tweet_image_url": tweet[:tweet_image_url],
      "tweet_date": tweet[:tweet_date],
      "tweet_retweet_count": tweet[:tweet_retweet_count],
      "tweet_favorite_count": tweet[:tweet_favorite_count]
    )

    redirect_back fallback_location: app_root_path, notice: 'Successfully collected twitter post!'
  end

  def delete_tweet
    record = current_user.testimonials.find_by(tweet_status_id: params['status_id'])
    return render_bad_request if record.nil?

    record.destroy
    redirect_back fallback_location: app_root_path, notice: 'Removed twitter post!'
  end

  private

  def tweet_params
    params.require(:testimonial).permit(:name, :content, :social_link, :tweet_status_id, :tweet_url, :tweet_user_id,
                                        :tweet_image_url, :tweet_date, :tweet_retweet_count, :tweet_favorite_count)
  end

  def set_collected_tweets
    @collected_tweets = current_user.testimonials.tweets
  end

  def set_fire_link
    @fire_link = FireLink.friendly.find_by(slug: params[:fire_link_id])
  end

  def testimonial_params
    params.require(:testimonial).permit(:name, :company, :role, :social_link, :rich_text, :image)
  end
end
