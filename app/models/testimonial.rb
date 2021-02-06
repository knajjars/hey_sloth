class Testimonial < ApplicationRecord
  include Hashid::Rails

  enum source: %i[text tweet]

  has_rich_text :rich_text

  belongs_to :user
  belongs_to :shareable_link, optional: true
  has_one_attached :image

  before_validation { self.content = self.rich_text.to_plain_text unless self.rich_text.nil? }

  validates_presence_of :name
  validates_presence_of :content
  validates :image,
            attached: true,
            if: ->(testimonial) { !testimonial.tweet? && testimonial.shareable_link.image_required },
            content_type: %i[png jpg jpeg]

  def self.with_rich_text
    with_rich_text_rich_text
  end

  def self.tweets
    where(source: Testimonial.sources[:tweet])
  end

  def self.showcased
    where(showcase: true)
  end

  def has_image?
    tweet_image_url.present? || image.attached?
  end

  def rich_text_or_content
    rich_text.nil? ? content : rich_text
  end
end
