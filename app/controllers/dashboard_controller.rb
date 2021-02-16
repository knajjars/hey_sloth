class DashboardController < ApplicationController
  def index
    @testimonials = current_user.testimonials
  end
end