class AdminController < ApplicationController
  authorize_resource :class => AdminController
  def index
  end
end
