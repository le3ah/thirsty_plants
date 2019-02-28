class UsersController < ApplicationController
  def show
    @user = current_user
    @next_seven_days = next_seven_days
    @facade = DashboardFacade.new(current_user)
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
end
