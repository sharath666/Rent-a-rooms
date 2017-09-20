class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
before_action :authenticate_user!

rescue_from CanCan::AccessDenied do 
   	redirect_to root_path, notice: "page not found"
   end

  rescue_from ActiveRecord::RecordNotFound do 
    redirect_to root_path, notice: "record not found"
  end

   before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name, :role_id, :mobile, :email])
  end
end
