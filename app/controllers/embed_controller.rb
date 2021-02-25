class EmbedController < ApplicationController
  include ActionView::Helpers::AssetUrlHelper
  include Webpacker::Helper

  before_action :allow_iframe_requests, only: :widget
  before_action :set_hey_wall, only: :widget

  def widget; end

  private

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

  def set_hey_wall
    user = User.find_by_public_token(params[:token])
    return render_not_found if user.nil?

    @testimonials = user.testimonials.showcased
  end

end
