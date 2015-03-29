class ApplicationController < ActionController::Base
	
	include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected
  def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:account_update) << :name
	  devise_parameter_sanitizer.for(:account_update) << :cell_phone
	  devise_parameter_sanitizer.for(:account_update) << :information
	  devise_parameter_sanitizer.for(:account_update) << :avatar

	  devise_parameter_sanitizer.for(:sign_up) << :name
	  devise_parameter_sanitizer.for(:sign_up) << :cell_phone
	  devise_parameter_sanitizer.for(:sign_up) << :information
	  devise_parameter_sanitizer.for(:sign_up) << :avatar
	end
  
  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

end
