class DashboardPresenter
  def initialize(user)
    @user = user
  end
  
  def chance_of_rain(day_index)
    service = WeatherService.new(@user.latitude, @user.longitude)
    raw_weather_days = service.chance_of_rain[:daily][:data]
    weather_days = raw_weather_days.map do |raw_weather_day|
      WeatherDay.new(raw_weather_day)
    end
    weather_days[day_index].precip_probability * 100
  end
end