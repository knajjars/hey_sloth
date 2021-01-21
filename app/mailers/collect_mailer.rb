class CollectMailer < ApplicationMailer

  def new_testimonial(email, current_user)
    @greeting = "Hi"

    @collect_boxes = current_user.collect_boxes

    mail to: email, subject: 'Your opinion matters.'
  end
end
