class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:from_shareable_link_create, :from_shareable_link_new, :create]

  def render_not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404
  end

  def render_application_error
    render :file => "#{Rails.root}/public/500.html", :status => 500
  end

  def render_unauthorized
    render :file => "#{Rails.root}/public/401.html", :status => 401
  end
end
