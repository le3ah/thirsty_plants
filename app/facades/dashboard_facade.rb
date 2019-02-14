class DashboardFacade
  def initialize(user)
    @user = user
  end

  def weather(lat, long)
    DarkSkyService.new.chance_of_rain(lat, long)
  end
end
