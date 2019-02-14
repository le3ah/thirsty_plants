class DarkSkyService

  def get_weather(lat, long)
    response = conn.get("/forecast/#{ENV["darksky_api_secret"]}/#{lat},#{long}")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: "https://api.darksky.net") do |f|
      f.params[:exclude] = "minutely,hourly"
      f.adapter Faraday.default_adapter
    end
  end
end
