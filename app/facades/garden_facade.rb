class GardenFacade
  def initialize(user)
    @user = user
  end

  def weather(lat, long)
    @_weather ||= Weather.new(lat, long)
  end
  
  def has_weather?(garden)
    garden.lat && garden.long && weather(garden.lat, garden.long).weather_info
  end
end
