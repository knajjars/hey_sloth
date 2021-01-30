class TestimonialSerializer < ApplicationSerializer
  attributes :name, :company, :role, :social_link, :testimonial, :source, :tweet_status_id, :tweet_url,
             :tweet_user_id, :created_at, :image_url

  def image_url
    if object.tweet?
      object.tweet_image_url
    elsif object.image.attached?
      rails_blob_path object.image
    else
      nil
    end
  end
end
