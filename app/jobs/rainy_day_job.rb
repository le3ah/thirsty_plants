class RainyDayJob < ApplicationJob
  queue_as :default

  def perform
    text_users
  end

  private

  def text_users
    @num_texts = 0
    RainyDay.generate_rainy_days.each do |rainy_day|
      send_rainy_day_texts(rainy_day)
    end
    @num_texts
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

  def send_rainy_day_texts(rainy_day)
    rainy_day.gardens.each do |garden|
      garden.users.each do |user|
        @num_texts += 1
        RainyDayTexter.send_rainy_day_text(user, garden, rainy_day.chance_of_rain)
      end
    end
  end
end
