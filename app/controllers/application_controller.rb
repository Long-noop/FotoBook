class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_photo_index_path
    else
      feed_users_photos_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :avatar ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :avatar ])
  end
end
