class UsersController < ApplicationController
  def show
    @user = current_user
    @presenter = DashboardPresenter.new(@user)
  end
end
