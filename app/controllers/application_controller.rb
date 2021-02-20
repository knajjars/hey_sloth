class ApplicationController < ActionController::Base
  include Pundit
  include DeviseWhitelist
  include Pagy::Backend

  before_action :authenticate_user!, except: [:from_fire_link_create, :from_fire_link_new, :list_testimonials, :widget]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def render_not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404
  end

  def render_not_found_json
    render json: { "message": 'Not found' }, :status => 404
  end

  def render_bad_request
    render :file => "#{Rails.root}/public/400.html", :status => 400
  end

  def render_application_error
    render :file => "#{Rails.root}/public/500.html", :status => 500
  end

  def render_unauthorized
    render :file => "#{Rails.root}/public/401.html", :status => 401
  end

  private

  def user_not_authorized
    flash[:alert] = 'Not authorized'
    redirect_to(request.referrer || root_path)
  end
end
