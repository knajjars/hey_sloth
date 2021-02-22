class EmbedController < ApplicationController
  include ActionView::Helpers::AssetUrlHelper
  include Webpacker::Helper

  protect_from_forgery except: :widget

  def widget
    respond_to do |format|
      format.js { redirect_to sources_from_manifest_entries(['embed'], type: :javascript).first }
      format.css { redirect_to sources_from_manifest_entries(['application'], type: :stylesheet).first }
    end
  end
end