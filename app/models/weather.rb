class Weather
attr_reader :lat, :long, :garden

  def initialize(garden)
    @garden = garden
    @lat = garden.lat
    @long = garden.long
  end

  def chance_of_rain(day_index)
    raw_day = weather_info["daily"]["data"][day_index]
    raw_day["precipProbability"] * 100
  end

  def weather_info
    unless garden.weather_data
      garden.update(weather_data: dark_sky_service.get_weather(@lat, @long))
    end
    garden.weather_data
  end

  def dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new
  end
end
