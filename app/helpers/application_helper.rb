module ApplicationHelper
  def formatted_date(date, with_time_passed:)
    formatted_date = date.strftime('%B %d, %Y').to_s
    formatted_date << "(#{time_ago_in_words date} ago)" if with_time_passed
    formatted_date
  end

  def current_controller?(name)
    name == controller.controller_name
  end
end
