class UsersController < ApplicationController
  def show
    @user = current_user
    @next_seven_days = next_seven_days
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
end
