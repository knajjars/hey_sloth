module TestimonialsHelper
  def display_image(testimonial, class_names:, alt:)
    if testimonial.tweet? && testimonial.tweet_image_url.present?
      image_tag testimonial.tweet_image_url, alt: alt, class: class_names
    elsif testimonial.image.attached?
      image_tag testimonial.image, alt: alt, class: class_names
    else
      svg = <<~SVG
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
         <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z" clip-rule="evenodd"/>
        </svg>
      SVG

      svg.html_safe
    end
  end
end
