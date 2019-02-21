class SessionsController < ApplicationController
  skip_before_action :require_login

  def create
    user = User.from_google_auth(request.env["omniauth.auth"])
    if user && user.role == "admin"
      session[:user_id] = user.id
      flash[:success] = "Welcome, Admin #{user.first_name}!"
      redirect_to admin_dashboard_path
    else
      session[:user_id] = user.id
      flash[:success] = "Welcome, gardener; water you waiting for!?"
      redirect_to dashboard_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
