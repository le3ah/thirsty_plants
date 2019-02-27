class UnwateredNotifierJob < ApplicationJob
  queue_as :default

  def perform
    User.with_missed_waterings.each do |user|
      UnwateredNotifierMailer.inform(user).deliver_now
    end
  end
  
end
