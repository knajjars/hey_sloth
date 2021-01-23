class ShareableLink < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :user
  has_many :testimonials
  has_one_attached :logo

  validates :tag,
            presence: true,
            length: { in: 4..30 }
  validates :logo, content_type: [:png, :jpg, :jpeg]

  def slug_candidates
    [:tag, :tag_and_sequence]
  end

  def tag_and_sequence
    slug = normalize_friendly_id(tag)
    sequence = ShareableLink.where("slug like '#{slug}-%'").count + 2
    "#{slug}-#{sequence}"
  end

  def should_generate_new_friendly_id?
    tag_changed?
  end
end
