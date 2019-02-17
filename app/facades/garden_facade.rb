class GardenFacade
  def initialize(user)
    @user = user
  end

  def weather(lat, long)
    Weather.new(lat, long)
  end
end
