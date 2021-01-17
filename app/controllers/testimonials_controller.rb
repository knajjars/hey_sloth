class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:show, :edit, :update, :destroy]

  def index
    @testimonials = current_user.testimonials
  end

  def show
  end

  def new
    @testimonial = Testimonial.new
  end

  def edit
  end

  def create
    code = CollectLink.find_by("collect_code": collect_code)
    return render_unauthorized if code.nil?
    @testimonial = Testimonial.new(testimonial_params)
    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to @testimonial, notice: 'Testimonial was successfully created.' }
      else
        format.html { render :collect_new }
      end
    end
  end

  def update
    respond_to do |format|
      if @testimonial.update(testimonial_params)
        format.html { redirect_to @testimonial, notice: 'Testimonial was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @testimonial.destroy
    respond_to do |format|
      format.html { redirect_to testimonials_url, notice: 'Testimonial was successfully destroyed.' }
    end
  end

  def video_new
    @testimonial = Testimonial.new

  end

  def video_create
    @testimonial = current_user.testimonials.new(testimonial_params)
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
    params.require(:testimonial).permit(:user_name, :user_company, :user_role, :user_link, :user_testimonial, :user_id, :video)
  end

  def collect_code
    params.require(:collect_code)
  end
end
