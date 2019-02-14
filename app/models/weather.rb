class Weather
attr_reader :lat, :long, :day
  def initialize(lat, long, index)
    @lat = lat
    @long = long
    @day = index
  end

  def chance_of_rain
    raw_day = weather_info[:daily][:data][@day]
    raw_day[:precipProbability] * 100
  end

  def weather_info
    @_weather_info ||= dark_sky_service.get_weather(@lat, @long)
  end

  def dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new
  end
end
