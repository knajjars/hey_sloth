class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:show, :destroy]

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

  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end
end
