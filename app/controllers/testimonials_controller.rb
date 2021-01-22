class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:show, :destroy, :toggle_showcase]

  def index
    @testimonials = current_user.testimonials
  end

  def show
  end

  def destroy
    @testimonial.destroy
    respond_to do |format|
      format.html { redirect_to testimonials_url, notice: 'Testimonial was successfully destroyed.' }
    end
  end

  def toggle_showcase
    @testimonial.showcase = !@testimonial.showcase
    @testimonial.save

    redirect_back fallback_location: app_root_path
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end
end
