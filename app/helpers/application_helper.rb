module ApplicationHelper
  def check_connection(provider)
    if current_user.connection_with?(provider)
      link_to disconnect_path(social: provider.downcase), class: "#{provider}-m phone-verified row" do
        content_tag :span, 'Unlinked Twitter', class: 'verified'
      end
    else
      link_to user_twitter_omniauth_authorize_path(provider: provider.downcase),
              class: "#{provider}-m phone-verified row" do
        content_tag :span, 'Link Twitter account', class: 'un-verified'
      end
    end
  end
end
