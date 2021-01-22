class Testimonial < ApplicationRecord
  enum source: %i[text tweet]

  belongs_to :user
  belongs_to :shareable_link, optional: true
  has_one_attached :image

  validates_presence_of :name
  validates_presence_of :testimonial
  validates :image,
            attached: true,
            if: ->(testimonial) { !testimonial.tweet? && testimonial.shareable_link.image_required },
            content_type: [:png, :jpg, :jpeg]

  def self.tweets
    where(source: Testimonial.sources[:tweet])
  end
end
