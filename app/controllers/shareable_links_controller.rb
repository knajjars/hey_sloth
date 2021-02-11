class ShareableLinksController < ApplicationController
  before_action :set_shareable_link, only: [:edit, :update, :destroy]

<<<<<<< HEAD
  def show
    authorize @shareable_link
  end

  def index
    @shareable_links = current_user.shareable_links.with_rich_text_note
=======
  def index
    @shareable_link = current_user.shareable_links.with_rich_text_note
>>>>>>> 25aca334a649808160b36750cc670ed0e33b3809
  end

  def new
    @shareable_link = ShareableLink.new
  end

  def create
    shareable_link_attrs = shareable_link_params.merge({ user: current_user })
    @shareable_link = ShareableLink.new(shareable_link_attrs)

    respond_to do |format|
      if @shareable_link.save
        format.html { redirect_to shareable_links_path, notice: 'Shareable link was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    authorize @shareable_link
  end

  def update
    authorize @shareable_link
    respond_to do |format|
      if @shareable_link.update(shareable_link_params)
        format.html { redirect_to shareable_links_path, notice: 'Shareable link was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @shareable_link
    @shareable_link.destroy
    respond_to do |format|
      format.html { redirect_to shareable_links_path, notice: 'Shareable link was successfully destroyed.' }
    end
  end

  private

  def set_shareable_link
    @shareable_link = ShareableLink.friendly.find(params[:id])
    return render_not_found if @shareable_link.nil?
  end

  def shareable_link_params
    params.require(:shareable_link).permit(:tag, :note, :social_link_required, :job_required, :image_required, :logo)
  end
end
