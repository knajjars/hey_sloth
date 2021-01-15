class Users::AuthorizationController < ApplicationController
  def disconnect
    provider = params[:provider]
    current_user.authorizations.where(provider: provider.downcase).first.delete

    redirect_to root_path
  end

end
