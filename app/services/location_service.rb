class LocationService
  def get_latitude(zip_code)
    get_location_data(zip_code)[:results].first[:geometry][:location][:lat]
  end
  
  def get_longitude(zip_code)
    get_location_data(zip_code)[:results].first[:geometry][:location][:lng]
  end
  
  def get_location_data(zip_code)
    response = conn.get("/maps/api/geocode/json") do |f|
      f.params[:address] = zip_code
    end
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def conn
    Faraday.new('https://maps.googleapis.com') do |faraday|
      faraday.params[:key] = ENV['google_maps_api_key']
      faraday.adapter Faraday.default_adapter
    end
  end
end