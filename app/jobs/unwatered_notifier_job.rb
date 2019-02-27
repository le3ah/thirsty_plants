class UnwateredNotifierJob < ApplicationJob
  queue_as :default

  def perform

  end

  private

  def users_who_missed
    Watering.all_missed.joins(:users).eac
  end
end
