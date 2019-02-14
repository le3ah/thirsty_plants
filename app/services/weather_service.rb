class WeatherService
  
  def initialize(location)
    @latitude = location[:latitude]
    @longitude = location[:longitude]
  end
  
  def chance_of_rain
    conn = Faraday.new(url: "https://api.darksky.net")
    response = conn.get("/forecast/#{ENV['darksky_api_secret']}/#{@latitude},#{@longitude}")
    JSON.parse(response.body, symbolize_names: true)
  end
end