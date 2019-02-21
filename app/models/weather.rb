class Weather
attr_reader :lat, :long, :garden

  def initialize(garden)
    @garden = garden
    @lat = garden.lat
    @long = garden.long
  end
  
  def self.get_all_weather_data
    Garden.all.each do |garden|
      garden.update(weather_data: dark_sky_service.get_weather(garden.lat, garden.long))
    end
  end
  
  def self.dark_sky_service
    @_dark_sky_service ||= DarkSkyService.new
  end

  def chance_of_rain(day_index)
    raw_day = weather_info["daily"]["data"][day_index]
    raw_day["precipProbability"] * 100
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
    icon = 'fas fa-cloud-rain'
    if type == 'snow'
      icon = 'far fa-snowflake'
    elsif type == 'sleet'
      icon = 'fas fa-cloud-showers-heavy'
    end
    icon
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
