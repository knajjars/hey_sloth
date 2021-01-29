class User < ApplicationRecord
  include ActiveRecord::SecureToken::ClassMethods

  has_many :testimonials, dependent: :destroy
  has_many :shareable_links, dependent: :destroy
  has_many :authorizations, dependent: :destroy

  before_validation { self.public_token = generate_unique_secure_token if self.public_token.nil? }

  validates :public_token, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable,
         omniauth_providers: %i[twitter]

  def connection_with?(provider)
    auth = authorizations.where(provider: provider).first
    if auth.present?
      auth.token.present?
    else
      false
    end
  end

  def twitter
    Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret = Rails.application.credentials.twitter[:api_key_secret]
      config.access_token = authorizations.where(provider: "twitter").first.token
      config.access_token_secret = authorizations.where(provider: "twitter").first.secret
    end
  end
end
