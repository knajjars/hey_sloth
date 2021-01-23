class CollectController < ApplicationController
  before_action :get_collected_tweets, only: [:twitter_search, :twitter_post_new]
  before_action :set_shareable_link, only: [:from_shareable_link_new, :from_shareable_link_create, :send_email_create, :send_email_new]
  layout "page", only: :from_shareable_link_new

  def from_shareable_link_new
    @testimonial = Testimonial.new
    return render_not_found if @shareable_link.nil?
    @testimonial.user_id = @shareable_link.user.id
  end

  def from_shareable_link_create
    return render_unauthorized if @shareable_link.nil?
    @testimonial = @shareable_link.testimonials.new(testimonial_params)
    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to root_path, notice: 'Testimonial was successfully created.' }
      else
        format.html { render :from_shareable_link_new }
      end
    end
  end

  def send_email_new
  end

  def send_email_create
    email_addresses = params[:email_addresses].reject { |e| e.empty? }
    email_addresses.each do |email_address|
      CollectMailer.new_testimonial(email_address, @shareable_link).deliver
    end

    redirect_to @shareable_link, notice: "Successfully sent email to recipients!"
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
    Testimonial.create!(
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

  def set_shareable_link
    @shareable_link = ShareableLink.friendly.find_by(slug: params[:shareable_link_id])
  end

  def testimonial_params
    params.require(:testimonial).permit(:name, :company, :role, :social_link, :testimonial, :user_id, :image)
  end

end
