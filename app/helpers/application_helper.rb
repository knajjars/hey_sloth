module ApplicationHelper
  def check_connection(provider)
    if current_user.has_connection_with(provider)
      link_to disconnect_path(social: provider.downcase), class: "#{provider}-m phone-verified row" do
        content_tag :span, 'Verified', class: 'verified'
      end
    else
      link_to user_omniauth_authorize_path(provider: provider.downcase),
              class: "#{provider}-m phone-verified row" do
        content_tag :span, 'Click to verify', class: 'un-verified'
      end
    end
  end
end
