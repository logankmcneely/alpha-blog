# Helper functions available to all controllers, using helper_method
# will allow the function to be used in views as well

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  # end

  def logged_in?
    !!current_user
  end

  def require_user
    if !user_signed_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to new_user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :image_url])
    devise_parameter_sanitizer.permit(:sign_up)
  end

end
