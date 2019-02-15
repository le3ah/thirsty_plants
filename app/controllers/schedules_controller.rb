class SchedulesController < ApplicationController
  def create
    scheduler = Scheduler.new(current_user)
    scheduler.generate_schedule
    redirect_to schedules_path(anchor: "today")
  end
  def index
    @days = Day.generate_days(days_ago: 4, days_from_now: 7, user: current_user)
  end
end
