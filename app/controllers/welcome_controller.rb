class WelcomeController < ApplicationController
  layout "welcome"
  skip_before_action :require_login, only: [:index]
  
  def index
  end
end
