class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :require_login

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  def require_login
    render_404 unless user.id
  end
end
