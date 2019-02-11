class MemberController < ApplicationController
  authorize_resource :class => MemberController
  def index
  end

end
