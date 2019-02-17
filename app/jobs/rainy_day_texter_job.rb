class RainyDayTexterJob < ApplicationJob
  queue_as :default

  def perform
    users_with_phone_numbers.each do |user|
      send_rainy_day_text(user)
    end
    RainyDayTexterJob.set(wait_until: early_next_morning).perform_later
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
      body: "Heads up from thirsty plants! There is a #{chance}% chance of precipitation in your area today."
    )
  end
end
