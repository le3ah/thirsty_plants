class SchedulesController < ApplicationController
  def index
    @days = Day.generate_days(days_ago: 4, days_from_now: 7, user: current_user)
  end
end
