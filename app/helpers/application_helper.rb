module ApplicationHelper
  include Pagy::Frontend

  def formatted_date(date, with_time_passed:)
    formatted_date = date.strftime('%B %d, %Y').to_s
    formatted_date << " (#{time_ago_in_words date} ago)" if with_time_passed
    formatted_date
  end

  def current_controller?(name)
    name == controller_name
  end

  def current_action?(action)
    action == action_name
  end

  def controller_and_action?(controller, action)
    current_controller?(controller) && current_action?(action)
  end

  def dashboard_partial?
    return true if controller_and_action?('registrations', 'edit')

    controllers_whitelist = %w[testimonials collect shareable_links dashboard]
    controllers_whitelist.include?(controller_name)
  end

  def embed_tweet(t)
    tweet = TwitterApi.client.oembed(t, hide_thread: true)
    raw(tweet.html)
  end
end
