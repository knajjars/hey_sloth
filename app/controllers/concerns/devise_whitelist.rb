module DeviseWhitelist
  extend ActiveSupport::Concern
  included do
    before_action :configure_params, if: :devise_controller?
  end

  def configure_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:company_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:company_name])
  end
end
