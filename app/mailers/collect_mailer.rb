class CollectMailer < ApplicationMailer

  def new_testimonial(email, fire_link)
    @greeting = "Hi"

    @fire_link = fire_link

    mail to: email, subject: 'Your opinion matters.'
  end
end
