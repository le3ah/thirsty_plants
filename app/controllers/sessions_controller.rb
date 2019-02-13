class SessionsController < ApplicationController
  def create
    if user = User.from_google_auth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      flash[:success] = "Welcome, gardner, we're glad to have you among the roses."
      redirect_to dashboard_path
    end
  end
end
