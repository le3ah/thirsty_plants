class Weather
attr_reader :lat, :long
  def initialize(lat, long)
    @lat = lat
    @long = long
  end

  def chance_of_rain(day_index)
    raw_day = weather_info[:daily][:data][day_index]
    raw_day[:precipProbability] * 100
  end

  def precip_icon(day_index)
    raw_day = weather_info[:daily][:data][day_index]
    raw_day[:icon]
  end

  def weather_info
    @_weather_info ||= dark_sky_service.get_weather(@lat, @long)
  end

  def dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new
  end
end
