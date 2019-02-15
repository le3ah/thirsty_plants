class ZipcodeFinder
  def initialize(zip_code)
    @zip_code = zip_code
  end
  
  def latitude
    find_zip.latitude
  end
  
  def longitude
    find_zip.longitude
  end
  
  def find_zip
    existing_zip = Zipcode.find_by(zip_code: @zip_code)
    if existing_zip
      existing_zip
    else
      lat = LocationService.new(@zip_code).get_latitude
      long = LocationService.new(@zip_code).get_longitude
      Zipcode.create(zip_code: @zip_code, latitude: lat, longitude: long)
    end
  end
end