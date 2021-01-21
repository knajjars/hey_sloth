class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:show, :edit, :update, :destroy]

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

  # move from here to collect
  def video_new
    @testimonial = Testimonial.new
  end

  def video_create
    @testimonial = current_user.testimonials.new(testimonial_params)
    @testimonial.video!
    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to @testimonial, notice: 'Testimonial was successfully created.' }
      else
        format.html { render :video_new }
      end
    end
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

  def testimonial_params
    params.require(:testimonial).permit(:name, :company, :role, :social_link, :testimonial, :user_id, :video)
  end

  def tag
    params.require(:tag)
  end
end
