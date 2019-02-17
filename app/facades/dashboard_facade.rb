class DashboardFacade
  def initialize(user)
    @user = user
  end

  def weather(lat, long)
    @_weather ||= Weather.new(lat, long)
  end
end
