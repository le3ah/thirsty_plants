class RainyDay

  def self.gardens_to_check_weather_for
    Garden.joins(:user).where.not(users: {telephone: nil})
  end

  def self.generate_rainy_days
    gardens_to_check_weather_for.pluck(:zip_code).distinct
  end
end
