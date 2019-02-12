class Users::InvitationsController < Devise::InvitationsController
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # POST /resource/invitation
  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      puts "RESOURCE_INVITED"
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, :email => self.resource.email
        puts "IS_FLASHING_FORMAT"
      end
      if self.method(:after_invite_path_for).arity == 1
        puts "SELF METHOD - AFTER INVITE ONE"
        respond_with resource, :location => after_invite_path_for(current_inviter)
      else
        puts "SELF METHOD - AFTER INVITE TWO"
        respond_with resource, :location => after_invite_path_for(current_inviter, resource)
      end
    else
      puts "NO RESOURCE_INVITED"
      respond_with_navigational(resource) { render :new }
    end
  end

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
    puts "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
    puts invite_params
    puts current_inviter
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