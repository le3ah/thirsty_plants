class RainyDayTexterJob < ApplicationJob
  queue_as :rainy_day

  def perform(just_set_up = nil)
    text_users unless just_set_up
    @scheduled_time = early_next_morning
    RainyDayTexterJob.set(wait_until: @scheduled_time).perform_later
    send_admin_text
  end

  private

  def send_admin_text
    MyTwillioClient.api.account.messages.create(
      from: '+12028834286',
      to: "+1#{ENV['ADMIN_PHONE_NUMBER']}",
      body: "Thirsty Plants has scheduled RainyDayTexterJob for #{@scheduled_time}"
    )
  end

  def text_users
    users_with_phone_numbers.each do |user|
      send_rainy_day_text(user)
    end
  end

  def early_next_morning
    self.class.early_next_morning
  end

  def self.early_next_morning
    Time.use_zone("Mountain Time (US & Canada)") { 1.day.from_now.beginning_of_day + 5.hours }
  end

  def users_with_phone_numbers
    User.where.not(telephone: nil)
  end

  def send_rainy_day_text(user, chance = 110)
    MyTwillioClient.api.account.messages.create(
      from: '+12028834286',
      to: "+1#{user.telephone}",
      body: "Heads up from Thirsty Plants! There is a #{chance}% chance of precipitation in your area today."
    )
  end
end
