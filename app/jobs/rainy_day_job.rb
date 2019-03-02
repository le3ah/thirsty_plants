class RainyDayJob < ApplicationJob
  queue_as :default

  def perform
    inform_users
  end

  private

  def inform_users
    @num_texts = 0; @num_emails = 0
    RainyDay.generate_rainy_days.uniq(&:zip_code).each do |rainy_day|
      send_rainy_day_messages(rainy_day)
    end
    {num_texts: @num_texts, num_emails: @num_emails}
  end

  def send_rainy_day_messages(rainy_day)
    rainy_day.gardens.each do |garden|
      send_texts(garden, rainy_day)
      send_email(garden, rainy_day)
    end
  end

  def send_texts(garden, rainy_day)
    users_to_text(garden).each do |user|
      @num_texts += 1
      RainyDayTexter.send_rainy_day_text(user, garden, rainy_day.chance_of_rain)
    end
  end

  def send_email(garden, rainy_day)
    users_to_email(garden).each do |user|
      @num_emails += 1
      RainyDayMailer.inform(user, garden, rainy_day.chance_of_rain).deliver_now
    end
  end

  def users_to_text(garden)
    garden.users.where(receive_texts: true, rainy_day_notifications: true)
  end

  def users_to_email(garden)
    garden.users.where(receive_emails: true, rainy_day_notifications: true)
  end
end
