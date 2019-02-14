class DarkSkyService
  def chance_of_rain(lat, long)
    conn = Faraday.new(url: "https://api.darksky.net") do |f|
      f.params[:exclude] = "minutely,hourly"
      f.adapter Faraday.default_adapter
    end
    response = conn.get("/forecast/#{ENV["darksky_api_secret"]}/#{lat},#{long}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
