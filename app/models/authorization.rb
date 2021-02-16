class Authorization < ApplicationRecord
  encrypts :token, :secret
  belongs_to :user

  validates :provider, presence: true, inclusion: { in: %w[twitter] }

  def twitter_handle
    "@#{link.split('/').last}"
  end
end
