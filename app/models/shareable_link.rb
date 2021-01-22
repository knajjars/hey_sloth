class ShareableLink < ApplicationRecord
  belongs_to :user
  has_many :testimonials
  has_one_attached :logo

  validates :tag, presence: true, uniqueness: true
  validates :logo, content_type: [:png, :jpg, :jpeg]
end
