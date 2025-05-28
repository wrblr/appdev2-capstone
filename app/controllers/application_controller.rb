class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  allow_browser versions: :modern

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :preferred_language_id, :image]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
