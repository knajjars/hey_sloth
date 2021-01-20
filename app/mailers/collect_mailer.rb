class CollectMailer < ApplicationMailer

  def new_testimonial(email, current_user)
    @greeting = "Hi"

    user_collect_link = current_user.collect_link
    if user_collect_link.nil?
      collect_code = Haikunator.haikunate
      @collect_link = CollectLink.create("tag": collect_code, user: current_user)
    else
      @collect_link = current_user.collect_link
    end

    mail to: email, subject: 'Your opinion matters.'
  end
end
