class Users::InvitationsController < Devise::InvitationsController
  # before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  # this is called when creating invitation
  # should return an instance of resource class
  # def invite_resource
  #   ## skip sending emails on invite
  #   super do |u|
  #     u.skip_invitation = true
  #   end
  # end
  def invite_resource(&block)
    resource_class.invite!(invite_params, current_inviter, &block)
    
  end

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    resource_class.accept_invitation!(update_resource_params)
    ## Report accepting invitation to analytics
   
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name])
  #   #devise_parameter_sanitizer.permit(:invite, keys: [:email, :first_name, :last_name])
    
  # end

  def after_accept_path_for(resource)
    flash[:notice] = 'Password created.'
    puts "ACCEPTED"
    member_path
  end

  def after_invite_path_for(current_inviter)
    flash[:notice] = 'Invitation sent.'
    puts "INVITED"
    new_user_invitation_path
  end
  
end