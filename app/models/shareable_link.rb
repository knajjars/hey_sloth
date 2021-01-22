class ShareableLink < ApplicationRecord
  belongs_to :user

  validates :tag, presence: true, uniqueness: true

end
