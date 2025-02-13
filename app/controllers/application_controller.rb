class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!

  protected

  # Redirect user to their profile page after login
  def after_sign_in_path_for(resource)
    user_path(current_user) # Redirect to current user's profile page
  end
end
