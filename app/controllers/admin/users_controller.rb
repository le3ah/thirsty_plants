class Admin::UsersController < ApplicationController
  def index
    @default_users = User.default
  end

end
