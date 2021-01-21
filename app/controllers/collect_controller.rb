class CollectController < ApplicationController
  before_action :get_collected_tweets, only: [:twitter_search, :twitter_post_new]
  before_action :set_hey_box, only: [:from_hey_box_new, :from_hey_box_create]
  layout "page", only: :from_hey_box_new

  def get_send_email
  end

  def from_hey_box_new
    @testimonial = Testimonial.new
    return render_not_found if @hey_box.nil?
    @testimonial.user_id = @hey_box.user.id
  end

  def from_hey_box_create
    return render_unauthorized if @hey_box.nil?
    @testimonial = Testimonial.new(testimonial_params)
    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to root_path, notice: 'Testimonial was successfully created.' }
      else
        format.html { render :from_hey_box_new }
      end
    end
  end

  def post_send_email
    email_addresses = params[:email_addresses].reject { |e| e.empty? }
    email_addresses.each do |email_address|
      CollectMailer.new_testimonial(email_address, current_user).deliver
    end

    redirect_to collect_send_email_path, notice: "Successfully sent email to recipients!"
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
      "name": tweet[:name],
      "testimonial": tweet[:text],
      "source": "tweet",
      "social_link": tweet[:social_link],
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
    ActionController::Parameters.new(JSON.parse(params.require(:tweet))).permit(:name, :text, :status, :url, :user_id, :image_url, :social_link)
  end

  def get_collected_tweets
    @collected_tweets = current_user.testimonials.tweets
  end

  def set_hey_box
    @hey_box = HeyBox.find_by("tag": tag)
  end

  def tag
    params.require(:tag)
  end

  def testimonial_params
    params.require(:testimonial).permit(:name, :company, :role, :social_link, :testimonial, :user_id, :video)
  end

end
