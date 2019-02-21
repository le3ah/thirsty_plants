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

  def precip_type(day_index)
    type = weather_info[:daily][:data][day_index][:precipType]
    if type == nil
      type = "precipitation"
    end
    type
  end

  def precip_icon(day_index)
    type = weather_info[:daily][:data][day_index][:precipType]
    icon = 'fas fa-raindrops'
    if type == 'snow'
      icon = 'far fa-snowflakes'
    elsif type == 'sleet'
      icon = 'fas fa-cloud-sleet'
    end
    icon
  end

  def weather_info
    @_weather_info ||= dark_sky_service.get_weather(@lat, @long)
  end

  def dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new
  end
end
