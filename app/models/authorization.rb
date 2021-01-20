class Authorization < ApplicationRecord
  encrypts :token, :secret
  belongs_to :user
end
