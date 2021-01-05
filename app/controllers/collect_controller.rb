class CollectController < ApplicationController
  def collect

  end

  def send_email
  end

  def shareable_link
    user_collect_link = current_user.collect_link
    if user_collect_link.nil?
      collect_code = Haikunator.haikunate
      @collect_link = CollectLink.create("collect_code": collect_code, user: current_user)
    else
      @collect_link = current_user.collect_link
    end
  end

  def twitter_post
  end

  def twitter_search
  end
end
