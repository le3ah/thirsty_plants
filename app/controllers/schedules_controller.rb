class SchedulesController < ApplicationController
  def create
    Scheduler.generate_schedule(current_user)
    redirect_to schedules_path
  end
  def index
    @days = Day.generate_days(days_ago: 4, days.from_now: 7, user: current_user)
  end
end
