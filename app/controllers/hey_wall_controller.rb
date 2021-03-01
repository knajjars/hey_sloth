class HeyWallController < ApplicationController

  def show
    @has_showcased_testimonials = current_user.testimonials.showcased.any?
  end

end