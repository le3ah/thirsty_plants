class RainyDayTexter < ApplicationTexter

  def self.send_rainy_day_text(user, garden, chance)
    MyTwillioClient.api.account.messages.create(rainy_day_text(user, garden, chance))
  end

  def self.send_admin_text(scheduled_time)
    MyTwillioClient.api.account.messages.create(admin_text(scheduled_time))
  end

  private

  def self.rainy_day_text(user, garden, chance)
    attribution = user.own_gardens.include?(garden) ? "your garden" : "#{user.first_name}'s garden"
    {
      from: TwillioAccountPhoneNumber,
      to: "+1#{user.telephone}",
      body: "Heads up from Thirsty Plants! There is a #{chance}% chance of precipitation today in #{attribution} #{garden.name} at #{garden.zip_code}."
    }
  end

  def self.admin_text(scheduled_time)
    {
      from: TwillioAccountPhoneNumber,
      to: "+1#{ENV['ADMIN_PHONE_NUMBER']}",
      body: "Thirsty Plants has scheduled RainyDayJob for #{scheduled_time}"
     }
  end
end
