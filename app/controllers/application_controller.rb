class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
  
  
end
Refile.secret_key = '7db173ed4e10f2eaf3cf04e1d6ef789670fbbe76c701e672c26b32f6104d486eb166bcece96baf5ef4555a8e63fffce3b28da49be6361b8f8ccf31d0c6374cce'
