class Users::AuthorizationController < ApplicationController
  def disconnect
    provider = params[:provider]
    current_user.authorizations.where(provider: provider.downcase).first.delete

    redirect_to edit_user_registration_path
  end
end
