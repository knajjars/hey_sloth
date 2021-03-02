class FireLinkController < ApplicationController
  before_action :set_fire_link, only: %i[edit update destroy]

  def index
    @fire_link = current_user.fire_link
  end

  def new
    @fire_link = FireLink.new
  end

  def create
    fire_link_attrs = fire_link_params.merge({ user: current_user })
    @fire_link = FireLink.new(fire_link_attrs)

    respond_to do |format|
      if @fire_link.save
        format.html { redirect_to fire_link_index_path, notice: 'Fire link was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    authorize @fire_link
  end

  def update
    authorize @fire_link
    respond_to do |format|
      if @fire_link.update(fire_link_params)
        format.html { redirect_to fire_link_index_path, notice: 'Fire link was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @fire_link
    @fire_link.destroy
    respond_to do |format|
      format.html { redirect_to fire_link_index_path, notice: 'Fire link was successfully destroyed.' }
    end
  end

  private

  def set_fire_link
    @fire_link = FireLink.friendly.find(params[:id])
    return render_not_found if @fire_link.nil?
  end

  def fire_link_params
    params.require(:fire_link).permit(:url, :note, :social_link_required, :job_required, :image_required, :logo)
  end
end
