class DashboardFacade
  def initialize(user)
    @user = user
  end

  def weather(lat, long, index)
    Weather.new(lat, long, index)
  end  
end
