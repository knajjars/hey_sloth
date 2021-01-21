class HeyBoxesController < ApplicationController
  before_action :set_hey_box, only: [:show, :edit, :update, :destroy]

  def index
    @hey_boxes = current_user.hey_boxes.all
  end

  def show
  end

  def new
    @hey_box = HeyBox.new
  end

  def edit
  end

  def create
    hey_box_attrs = hey_box_params.merge({ user: current_user })
    @hey_box = HeyBox.new(hey_box_attrs)

    respond_to do |format|
      if @hey_box.save
        format.html { redirect_to @hey_box, notice: 'Hey box was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @hey_box.update(hey_box_params)
        format.html { redirect_to @hey_box, notice: 'Hey box was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @hey_box.destroy
    respond_to do |format|
      format.html { redirect_to hey_boxes_url, notice: 'Hey box was successfully destroyed.' }
    end
  end

  private

  def set_hey_box
    @hey_box = HeyBox.find(params[:id])
  end

  def hey_box_params
    params.require(:hey_box).permit(:tag, :note, :social_link_required, :email_required, :job_required, :allowed_sources)
  end
end
