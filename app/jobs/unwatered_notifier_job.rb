class UnwateredNotifierJob < ApplicationJob
  queue_as :default

  def perform
    users_to_email.each do |user|
      UnwateredNotifierMailer.inform(user).deliver_now
    end
  end

  private

  def users_to_email
    users_to_contact.where(receive_emails: true)
  end

  def users_to_contact
    User.with_missed_waterings.where(missed_watering_notifications: true)
  end
end
