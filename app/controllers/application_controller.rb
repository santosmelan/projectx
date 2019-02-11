class ApplicationController < ActionController::Base
  
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?


  #used by cancancan
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Sorry, either you are not authorized to access the page or the page doesn't exist. Redirected back to home."
    redirect_to after_sign_in_path_for(current_user)
  end

  protected

  #used by devise_invitable
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:email, :first_name, :last_name])
  end

  #used by devise
  def after_sign_in_path_for(users)
    #flash.keep
    if signed_in?
      if users.role == 'member'
        main_app.member_path
      elsif users.role == 'admin' || users.role == 'super_admin'
        main_app.admin_path
      end
    else
      main_app.root_path
    end
  end

  #used by devise
  def after_sign_out_path_for(users)
    root_path
  end

end