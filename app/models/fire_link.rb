class FireLink < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_rich_text :note

  belongs_to :user
  has_many :testimonials, dependent: :nullify
  has_one_attached :logo

  validates :url,
            presence: true,
            length: { in: 4..30 },
            url_exclusion: true
  validates :logo, attached: true, content_type: %i[png jpg jpeg]

  after_validation :restore_slug

  def save_slug
    @original_slug = slug
  end

  def restore_slug
    self.slug = @original_slug if errors.any?
  end

  def slug_candidates
    %i[url url_and_sequence]
  end

  def url_and_sequence
    slug = normalize_friendly_id(url)
    sequence = FireLink.where("slug like '#{slug}-%'").count + 2
    "#{slug}-#{sequence}"
  end

  def should_generate_new_friendly_id?
    save_slug
    url_changed?
  end
end
