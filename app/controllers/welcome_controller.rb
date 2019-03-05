class WelcomeController < ApplicationController
  layout "welcome"
  skip_before_action :require_login, only: [:index]

  def index
    redirect_to dashboard_path if current_user
  end
end
