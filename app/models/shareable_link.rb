class ShareableLink < ApplicationRecord
  belongs_to :user
  has_many :testimonials
  has_one_attached :logo

  validates :tag,
            presence: true,
            uniqueness: true,
            exclusion: { in: %w(admin image images javascript 404 index new users admin login logout signin administrator log-in log-out sign-in log-out heysloth),
                         message: "%{value} is reserved." },
            length: { in: 4..30 }
  validates :logo, content_type: [:png, :jpg, :jpeg]
end
