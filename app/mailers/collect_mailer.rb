class CollectMailer < ApplicationMailer

  def new_testimonial(email, current_user)
    @greeting = "Hi"

    @hey_boxes = current_user.hey_boxes

    mail to: email, subject: 'Your opinion matters.'
  end
end
