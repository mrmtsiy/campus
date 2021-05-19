class ApplicationController < ActionController::Base
before_action :authenticate_user! , except: [:show, :index]
before_action :configure_permitted_parameters, if: :devise_controller?
private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :profile])

    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :profile])
  end

end
