class DashboardFacade
  def initialize(user)
    @user = user
  end

  # def chance_of_rain(index, lat, long)
  #   raw_weather = dark_sky_service.get_weather(lat, long)
  #   raw_day = raw_weather[:daily][:data][index]
  #   raw_day[:precipProbability] * 100
  # end

  # def chance_of_rain(index, lat, long)
  #   data = dark_sky_service.get_weather(lat, long)
  #   Weather.new(data, index)
  # end

  def weather(lat, long, index)
    Weather.new(lat, long, index)
  end

  
end
