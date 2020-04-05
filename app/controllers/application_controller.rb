class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?

 protected

 def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :about])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :about])
 end
 
 def after_sign_in_path_for(resource)
  user_root_path(current_user)
 end
 
end
