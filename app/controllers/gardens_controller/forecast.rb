class GardensController::Forecast
  attr_reader :forecast

  def initialize
    @forecast = ForecastIO::Forecast.new
  end
  #in an appropriate controller ForecastIO controller
#   ForecastIO.configure do |c|
#   c.api_key = api_key
# end
end
