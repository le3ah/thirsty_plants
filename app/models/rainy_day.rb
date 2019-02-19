class RainyDay
  attr_reader :chance_of_rain, :zip_code
  def initialize(args)
    @chance_of_rain = args[:chance]
    @zip_code = args[:zip_code]
  end

  def self.gardens_to_check_weather_for
    @@_gardens = Garden.joins(:user).where.not(users: {telephone: nil})
  end

  def self.generate_rainy_days
    zip_codes.map do | zip_code |
      zip_code_finder = ZipcodeFinder.new(zip_code)
      weather = Weather.new(zip_code_finder.latitude, zip_code_finder.longitude)
      if weather.chance_of_rain(0) > 50
        RainyDay.new(chance: weather.chance_of_rain, zip_code: zip_code)
      end
    end
  end

  def self.zip_codes
    gardens_to_check_weather_for.distinct.pluck(:zip_code)
  end



  def gardens

  end
end
