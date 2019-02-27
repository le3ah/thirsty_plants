class GardenFacade
  def initialize(user)
    @user = user
  end

  def weather(garden)
    Weather.new(garden)
  end

  def has_weather?(garden)
    garden.lat && garden.long && weather(garden).weather_info
  end
end
