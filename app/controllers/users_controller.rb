class UsersController < ApplicationController
  def show
    @user = current_user
    @next_seven_days = next_seven_days
    @facade = DashboardFacade.new(current_user)
  end

  def update
    current_user.telephone = phone_params
    redirect_to dashboard_path
  end

  private
  def next_seven_days
    days = []
    i = 1
    7.times do
      days << (Time.now + i.days).strftime('%A')
      i += 1
    end
    days
  end

  def phone_params
    params["user"]["telephone"]
  end
end
