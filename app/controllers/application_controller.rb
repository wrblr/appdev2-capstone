class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  before_action :configure_permitted_parameters, if: :devise_controller?
  allow_browser versions: :modern

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :preferred_language_id, :image]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
