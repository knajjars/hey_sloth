class Testimonial < ApplicationRecord
  belongs_to :user
  has_one_attached :video

  validates_presence_of :testimonial, :name

  enum source: %i[text video tweet]

  def self.tweets
    where(source: Testimonial.sources[:tweet])
  end
end
