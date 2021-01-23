class CollectMailer < ApplicationMailer

  def new_testimonial(email, shareable_link)
    @greeting = "Hi"

    @shareable_link = shareable_link

    mail to: email, subject: 'Your opinion matters.'
  end
end
