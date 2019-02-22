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

  def send_rainy_day_texts(rainy_day)
    rainy_day.gardens.each do |garden|
      garden.users.where.not(telephone: nil).each do |user|
        @num_texts += 1
        RainyDayTexter.send_rainy_day_text(user, garden, rainy_day.chance_of_rain)
      end
    end
  end
end
