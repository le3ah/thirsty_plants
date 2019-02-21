class UsersController < ApplicationController
  def show
    @user = current_user
    @next_seven_days = next_seven_days
    @facade = DashboardFacade.new(current_user)
  end

  def update
    current_user.telephone = phone_params
    if current_user.save
      flash[:success] = "Thanks for submitting your phone number. You will now recieve texts with weather info as it relates to your garden!"
    end
    redirect_to dashboard_path
  end

  private
  def next_seven_days
    days = []
    i = 0
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
