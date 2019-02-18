class LocationService
  def initialize(zip_code)
    @zip_code = zip_code
  end
  
  def get_latitude
    get_location_data[:results].first[:geometry][:location][:lat]
  end
  
  def get_longitude
    get_location_data[:results].first[:geometry][:location][:lng]
  end
  
  private
  
  def get_location_data
    Rails.cache.fetch("location_data_#{@zip_code}") do
      response = conn.get("/maps/api/geocode/json") do |f|
        f.params[:address] = @zip_code
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end
  
  def conn
    Faraday.new('https://maps.googleapis.com') do |faraday|
      faraday.params[:key] = ENV['google_maps_api_key']
      faraday.adapter Faraday.default_adapter
    end
  end
end