class Testimonial < ApplicationRecord
  belongs_to :user
  
  validates_presence_of :name
  validates_presence_of :testimonial

  enum source: %i[text tweet]

  def self.tweets
    where(source: Testimonial.sources[:tweet])
  end
end
