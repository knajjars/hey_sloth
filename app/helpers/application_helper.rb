module ApplicationHelper
  def check_connection(provider)
    if current_user.connection_with?(provider.downcase)
      link_to disconnect_authorization_path(provider.downcase), method: :post do
        content_tag :span, 'Unlink Twitter'
      end
    else
      link_to user_twitter_omniauth_authorize_path do
        content_tag :span, 'Link Twitter account'
      end
    end
  end
end
