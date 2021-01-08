class TwitterApi
  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret = Rails.application.credentials.twitter[:api_key_secret]
      config.access_token = Rails.application.credentials.twitter[:api_access_token]
      config.access_token_secret = Rails.application.credentials.twitter[:api_access_token_secret]
    end
  end
end