class CollectMailer < ApplicationMailer

  def new_testimonial(email, current_user)
    @greeting = "Hi"

    @shareable_links = current_user.shareable_links

    mail to: email, subject: 'Your opinion matters.'
  end
end
