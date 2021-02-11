class ShareableLink < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_rich_text :note

  belongs_to :user
  has_many :testimonials, dependent: :nullify
  has_one_attached :logo

  validates :tag,
            presence: true,
            length: { in: 4..30 },
            tag_exclusion: true
  validates :logo, content_type: %i[png jpg jpeg]

  after_validation :restore_slug

  def save_slug
    @original_slug = slug
  end

  def restore_slug
    self.slug = @original_slug if errors.any?
  end

  def slug_candidates
    %i[tag tag_and_sequence]
  end

  def tag_and_sequence
    slug = normalize_friendly_id(tag)
    sequence = ShareableLink.where("slug like '#{slug}-%'").count + 2
    "#{slug}-#{sequence}"
  end

  def should_generate_new_friendly_id?
    save_slug
    tag_changed?
  end
end
