class Testimonial < ApplicationRecord
  include Hashid::Rails
  enum source: %i[text tweet]

  belongs_to :user
  belongs_to :shareable_link, optional: true
  has_one_attached :image

  validates_presence_of :name
  validates_presence_of :testimonial
  validates :image,
            attached: true,
            if: ->(testimonial) { !testimonial.tweet? && testimonial.shareable_link.image_required },
            content_type: %i[png jpg jpeg]

  def self.tweets
    where(source: Testimonial.sources[:tweet])
  end

  def self.showcased
    where(showcase: true)
  end

  def self.select_external_fields
    keys = %i[name company role social_link testimonial source tweet_status_id tweet_url tweet_image_url tweet_user_id created_at]
    pluck(*keys).map { |pa| Hash[keys.zip(pa)] }
  end
end
