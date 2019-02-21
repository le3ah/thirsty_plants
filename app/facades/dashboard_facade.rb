class DashboardFacade
  def initialize(user)
    @user = user
  end

  def weather(garden)
    @_weather ||= Weather.new(garden)
  end
  
  def has_weather?(garden)
    garden.lat && garden.long && weather(garden).weather_info
  end
end
