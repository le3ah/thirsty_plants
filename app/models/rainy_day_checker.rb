class RainyDayChecker
  def self.users_with_phone_numbers
    User.where.not(telephone: nil)
  end
  def self.gardens_to_check_weather_for
    Garden.joins(:user).where.not(user: {telephone: nil})
  end
end
