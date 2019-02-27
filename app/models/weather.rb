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
    type = weather_info["daily"]["data"][day_index]["precipType"]
    if type == nil
      type = "precipitation"
    end
    type
  end

  def precip_icon(day_index)
    type = weather_info["daily"]["data"][day_index]["precipType"]

    if type == 'snow' && chance_of_rain(day_index) >= 10
      icon = 'far fa-snowflake'
    elsif type == 'sleet' && chance_of_rain(day_index) >= 10
      icon = 'fas fa-cloud-showers-heavy'
    elsif type == 'rain' && chance_of_rain(day_index) >= 10
      icon = 'fas fa-cloud-rain'
    elsif type == nil && chance_of_rain(day_index) >= 10
      icon = 'fas fa-cloud-rain'
    else
      icon = 'fas fa-cloud-sun'
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
