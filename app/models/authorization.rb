class Authorization < ApplicationRecord
  encrypts :token, :secret
  belongs_to :user

  validates :provider, presence: true, inclusion: { in: %w[twitter] }
end
