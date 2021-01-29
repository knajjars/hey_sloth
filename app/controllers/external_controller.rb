class ExternalController < ApplicationController
  before_action :set_testimonials, only: [:list_testimonials]

  def list_testimonials
    json_body = @testimonials.showcased.select_external_fields
    render json: json_body
  end

  private

  def set_testimonials
    public_token = params.require(:public_token)
    user = User.find_by_public_token(public_token)
    return render_not_found_json if user.nil?

    @testimonials = user.testimonials
  end
end
