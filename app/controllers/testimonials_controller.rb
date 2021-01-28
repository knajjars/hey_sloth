class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:show, :destroy, :toggle_showcase]

  def index
    @testimonials = current_user.testimonials
  end

  def show
    authorize @testimonial
  end

  def destroy
    authorize @testimonial
    @testimonial.destroy
    respond_to do |format|
      format.html { redirect_to testimonials_url, notice: 'Testimonial was successfully destroyed.' }
    end
  end

  def toggle_showcase
    authorize @testimonial
    @testimonial.showcase = !@testimonial.showcase
    @testimonial.save!
    redirect_back fallback_location: app_root_path
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find_by_hashid(params[:id])
    return render_not_found if @testimonial.nil?
  end
end
