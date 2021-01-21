class HeyBox < ApplicationRecord
  belongs_to :user
  enum allowed_sources: %i[video_or_text video text ]

  validates :tag, presence: true, uniqueness: true

end
