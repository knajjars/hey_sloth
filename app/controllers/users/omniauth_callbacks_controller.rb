class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    twitter_data = request.env['omniauth.auth']
    auth_attr = { provider: 'twitter',
                  uid: twitter_data['extra']['raw_info']['id'],
                  token: twitter_data['credentials']['token'],
                  secret: twitter_data['credentials']['secret'],
                  link: "https://twitter.com/#{twitter_data['info']['nickname']}" }

    current_user.authorizations.build(auth_attr)
    current_user.save

    redirect_to collect_twitter_search_path
  end

  def failure
    redirect_to edit_user_registration_path
  end
end
