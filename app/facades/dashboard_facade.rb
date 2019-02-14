class DashboardFacade
  def initialize(user)
    @user = user
  end

  def weather(date, lat, long)
    DarkSkyService.new.chance_of_rain(date, lat, long)
  end
end
