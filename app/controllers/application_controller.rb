class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: :shared_url
end
