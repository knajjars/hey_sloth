class DashboardController < ApplicationController
  def index
    @pagy, @testimonials = pagy(current_user.testimonials.with_attached_image.order(created_at: :desc), items: 10)
    @showcased_testimonials = current_user.testimonials.showcased.count
  end
end