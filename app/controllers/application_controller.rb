class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!
  respond_to :json, :html
  protect_from_forgery with: :exception
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| 
      u.permit(:password, :password_confirmation, :current_password) 
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation) }
    }
  end

    def after_sign_in_path_for(resource)
      session[:previous_url] || root_path
    end

    def after_update_path_for(resource)
      session[:previous_url] || root_path
    end

    def after_sign_out_path_for(resource)
      session[:previous_url] || root_path
    end
end
