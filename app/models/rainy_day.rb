class RainyDay
  attr_reader :chance_of_rain, :zip_code
  def initialize(**args)
    @chance_of_rain = args[:chance_of_rain]
    @zip_code = args[:zip_code]
  end

  def self.gardens_to_check_weather_for
    @@_gardens ||= Garden.joins(:users).where.not(users: {telephone: nil})
  end

  def self.generate_rainy_days
    gardens_to_check_weather_for.map do | garden |
      weather = Weather.new(garden)
      if (chance = weather.chance_of_rain(0)) > 50
        RainyDay.new(chance_of_rain: chance, zip_code: garden.zip_code)
      end
    end.compact
  end

  def self.zip_codes
    gardens_to_check_weather_for.distinct.pluck(:zip_code)
  end

  def gardens
    self.class.gardens_to_check_weather_for.where(zip_code: self.zip_code)
  end
end
