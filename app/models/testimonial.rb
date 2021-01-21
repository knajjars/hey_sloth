class Testimonial < ApplicationRecord
  belongs_to :user
  has_one_attached :video

  validates_presence_of :name

  validates :testimonial,
            presence: true,
            if: ->(testimonial) { !testimonial.video.present? }
  validates :video,
            presence: true,
            if: ->(testimonial) { !testimonial.testimonial.present? }

  enum source: %i[text video tweet]

  def self.tweets
    where(source: Testimonial.sources[:tweet])
  end
end
