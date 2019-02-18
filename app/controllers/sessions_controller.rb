class SessionsController < ApplicationController
  skip_before_action :require_login

  def create
    user = User.from_google_auth(request.env["omniauth.auth"])
    if user && user.role == "default"
      session[:user_id] = user.id
      flash[:success] = "Welcome, gardener, we're glad to have you among the roses."
      redirect_to dashboard_path
    else
      user && user.role == "admin"
      session[:user_id] = user.id
      flash[:success] = "Welcome, Admin!"
      redirect_to admin_dashboard_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
