# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :authenticate_user!, unless: :public_page?

  protected

  def public_page?
    controller_name == 'home' && action_name == 'index'
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
end
