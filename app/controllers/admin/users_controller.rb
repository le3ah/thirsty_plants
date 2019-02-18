class Admin::UsersController < ApplicationController
  before_action :require_admin
  
  def index
    @default_users = User.default
  end

end
