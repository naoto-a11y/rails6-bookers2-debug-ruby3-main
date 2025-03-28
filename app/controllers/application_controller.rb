class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:about, :top]
  before_action :search_form, except: [:about, :top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
  
  def search_form
    @search = true
  end
end
